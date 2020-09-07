class User < ApplicationRecord
  include ActiveModel::Validations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :password, presence: true, password: true
  validates :username, uniqueness: { case_sensitive: false }

  before_validation :add_username_in_db

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  attr_writer :login

  def login
    @login || username || email
  end

  def add_username_in_db
    self.username = "#{firstname} #{lastname}"
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_hash).first
    end
  end

  ROLES = {
    client: 'client',
    admin: 'admin'
  }.freeze
  enum role: ROLES

  filterrific(
    available_filters: %i[search_query sorted_by]
  )
  scope :search_query, lambda { |query|
    return nil if query.blank?

    query = query.to_s
    terms = query.downcase.split(/\s+/)
    terms = terms.map do |e|
      (e.tr('*', '%') + '%').gsub(/%+/, '%')
    end
    num_or_conds = 3
    where(
      terms.map do |_term|
        '(LOWER(users.firstname) LIKE ? OR LOWER(users.lastname) LIKE ? OR LOWER(users.email) LIKE ?)'
      end.join('AND'),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_options|
    direction = sort_options =~ /desc$/ ? 'desc' : 'asc'

    case sort_options.to_s
    when /^username_/
      order("users.username #{direction}")
    when /^email_/
      order("users.username #{direction}")
    when /^id_/
      order("users.id #{direction}")
    else
      raise(ArgumentError, 'Invalid sort option')
    end
  }
  def self.options_for_sorted_by
    [
      %w[username (AZ) username_asc],
      %w[username (ZA) username_desc],
      %w[email (AZ) email_asc],
      %w[email (ZA) email_desc],
      %w[id id_asc],
      %w[id id_desc]
    ]
  end
end

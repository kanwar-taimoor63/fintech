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
    @login || self.username || self.email
  end

  def add_username_in_db
    self.username = "#{firstname} #{lastname}"
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_hash).first
    end
  end

  def self.to_csv
    attributes = %w{id name email role}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      User.find_each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def name
    "#{firstname} #{lastname}"
  end

  ROLES = {
    client: "client",
    admin: "admin"
  }.freeze
  enum role: ROLES
end

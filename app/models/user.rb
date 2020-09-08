class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :password, password: true
  validates :username, uniqueness: { case_sensitive: false }

  before_validation :add_username_in_db

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  attr_writer :login

  def self.search(search)
    if search
      where('users.username LIKE ? || users.email LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end

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
end

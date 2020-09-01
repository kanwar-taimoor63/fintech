class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #validate :validate_username
  validate :password_complexity
  validates :username, uniqueness: { case_sensitive: false }

  before_validation :add_username_in_db

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attr_writer :login

#function to create a login attribute
  def login
    @login || self.username || self.email
  end
#function to combine first name and last name in database as username
  def add_username_in_db
    self.username = self.firstname + " " + self.lastname
  end
#over ridden function of devise to allow username for authentication 
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_hash).first
    end
  end
#custom password validation
  def password_complexity
    rules = {
              " must contain at least one lowercase letter"  => /[a-z]+/,
              " must contain at least one uppercase letter"  => /[A-Z]+/,
              " must contain at least one digit"             => /\d+/,
              " must contain at least one special character" => /[^A-Za-z0-9]+/,
              " Length must be of atleast 8 characters" => /.{8,}$/
            }

    rules.each do |message, regex|
      errors.add(:password, message) unless password.match(regex)
    end
  end
end

# def validate_username
#     if User.where(username: username).exists?
#       errors.add(:username, :invalid)
#     end
#   end

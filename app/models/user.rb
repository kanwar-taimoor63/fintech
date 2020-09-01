class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validate :password_complexity
  validate :validate_username
  before_save :add_username_in_db
  attr_writer :login
  validates :username, uniqueness: { case_sensitive: false }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

def add_username_in_db
	self.username= self.firstname + " " + self.lastname
end

def validate_username
  if User.where(email: username).exists?
    errors.add(:username, :invalid)
  end
end
 

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)#conditions[:email].downcase! if conditions[:email]
        where(conditions.to_hash).first
      end
    end
def password_complexity
rules = {
    " must contain at least one lowercase letter"  => /[a-z]+/,
    " must contain at least one uppercase letter"  => /[A-Z]+/,
    " must contain at least one digit"             => /\d+/,
    " must contain at least one special character" => /[^A-Za-z0-9]+/,
    " Length must be of atleast 8 characters" => /.{8,}$/

  }

  rules.each do |message, regex|
    errors.add( :password, message ) unless password.match( regex )
  end


  

end
end

class User < ActiveRecord::Base

  has_secure_password
  validates :name, :email, :password, :password_confirmation, presence: true
  # Convert all entered 
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, length: { minimum: 6 }

  
end

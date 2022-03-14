class User < ActiveRecord::Base

  has_secure_password
  validates :name, :email, :password, :password_confirmation, presence: true
  # Convert all entered 
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, length: { minimum: 6 }

  # Force email to downcase before saving
  before_save { self.email = email.downcase }

  def self.authenticate_with_credentials(email, password)
    # Check if email stripped of white space and downcased matches password
    if user = User.find_by_email(email.strip.downcase)&.authenticate(password)
      user
    else
      nil
    end
  end

end

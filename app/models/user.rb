class User < ActiveRecord::Base
  
  has_secure_password

  has_many :reviews

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true, length: { minimum: 6 }

  private

  def self.authenticate_with_credentials(email, password)
    email.strip!
    email.downcase!
    user = User.find_by_email(email)
    # If the user exists AND the password entered is correct.
    user && user.authenticate(password)
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
  end

end

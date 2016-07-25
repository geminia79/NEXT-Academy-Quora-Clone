class User < ActiveRecord::Base
	has_many :questions
	has_many :answers

	has_secure_password
  validates :email, :name, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def self.authentication(email, password)
  	valid_user = self.find_by(email: email)
	  if valid_user != nil and valid_user.authenticate(password)
			valid_user
		else
			valid_user = nil
		end
  end
end






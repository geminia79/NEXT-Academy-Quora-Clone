class User < ActiveRecord::Base
	has_secure_password
  validates :email, :name, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end




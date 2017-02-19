class User < ApplicationRecord
  has_many :recipes

  has_secure_password

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false, message: "already taken"
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false, message: "already taken"
  validates_format_of :email, with: /.+@.+\..+/i, message: "email must contain '@' and '.'"

  def admin
    self.admin = true
  end
end

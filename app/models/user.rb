class User < ApplicationRecord
  has_many :recipes

  has_secure_password

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false, message: "already taken"
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false, message: "already taken"
  validates_format_of :email, with: /.+@.+\..+/i, message: "email must contain '@' and '.'"
  validates :password, :length => {:within => 6..40}

  def admin
    self.admin = true
  end

  def standardize_name
    pieces = self.name.split(" ")
    caps = pieces.map{|w| w.capitalize}
    self.name = caps.join(" ")
  end
end

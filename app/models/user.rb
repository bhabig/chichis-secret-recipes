class User < ApplicationRecord
  has_many :recipes

  has_secure_password

  validates :name, presence: true, on: :create
  validates :name, presence: true, allow_blank: true, on: :update, :unless => Proc.new {|c| c.name.empty?}
  validates_uniqueness_of :name, case_sensitive: false, message: "already taken"
  validates :email, presence: true, on: :create
  validates :email, presence: true, allow_blank: true, on: :update, :unless => Proc.new {|c| c.email.empty?}
  validates_uniqueness_of :email, case_sensitive: false, message: "already taken"
  validates_format_of :email, with: /.+@.+\..+/i, message: "email must contain '@' and '.'", on: :create
  validates_format_of :email, with: /.+@.+\..+/i, message: "email must contain '@' and '.'", on: :update, :unless => Proc.new {|c| c.email.empty?}
  validates :password, :length => {:within => 6..40}, on: :create
  validates :password, :length => {:within => 6..40}, on: :update, :unless => Proc.new {|c| c.password.nil?}

  def self.find_or_create_by_omniauth(auth)
    omni_email = auth["info"]["email"]
    if @user = User.find_by(email: omni_email)
      return @user
    else
      omni_name = auth["info"]["name"]
      @user = User.new(email: omni_email, password: SecureRandom.hex, name: omni_name)
    end
  end

  def admin
    self.admin = true
  end

  def admin?
    self.admin == true
  end

  def standardize_name
    pieces = self.name.split(" ")
    caps = pieces.map{|w| w.capitalize}
    self.name = caps.join(" ")
  end
end

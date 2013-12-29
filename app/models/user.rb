class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :email_notifications

  has_many :links
  has_many :comments

  scope :receiving_emails, ->{ where(email_notifications: true) }

  def full_name
    "#{first_name} #{last_name}"
  end
end

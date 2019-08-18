class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates(
    :first_name,
    :last_name,
    :email,
    presence: true
  )
  validates :password, length: { minimum: 6 }
end

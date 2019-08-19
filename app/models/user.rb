class User < ApplicationRecord
  has_secure_password

  has_many :posts
  has_many :likes, dependent: :destroy
  has_many :liked_posts, :through => :likes
  has_many :followings, dependent: :destroy
  has_many :followers, through: :friendships
  has_many :followeds, through: :friendships
  has_many :conversations, dependent: :destroy

  has_one_attached :profile_picture

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

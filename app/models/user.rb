class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, :through => :likes, source: :post

  has_many :followings_in, dependent: :destroy, foreign_key: "followed_id", class_name: 'Following'
  has_many :followings_out, dependent: :destroy, foreign_key: "follower_id", class_name: 'Following'
  has_many :followers, through: :followings_in
  has_many :followeds, through: :followings_out

  has_many :conversations_sent, dependent: :destroy, class_name: 'Conversation', foreign_key: "sender_id"
  has_many :conversations_received, dependent: :destroy, class_name: 'Conversation', foreign_key: "recipient_id"

  has_one_attached :profile_picture

  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates(
    :first_name,
    :last_name,
    :email,
    presence: true
  )
  validates :password, length: { minimum: 6 }, if: :password_required?

  private

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end

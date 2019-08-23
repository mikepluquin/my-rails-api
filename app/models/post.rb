class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liking_users, :through => :likes, source: :user

  def nb_likes
    likes.size
  end
end

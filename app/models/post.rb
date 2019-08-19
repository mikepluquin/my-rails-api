class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :liking_users, :through => :likes
end

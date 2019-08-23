class PostAndUserSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :body, :user, :likes
end

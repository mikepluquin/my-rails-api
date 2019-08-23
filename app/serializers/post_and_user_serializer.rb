class PostAndUserSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :body, :user, :nb_likes
end

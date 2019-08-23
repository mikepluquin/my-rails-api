class PostSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :body, :nb_likes
end

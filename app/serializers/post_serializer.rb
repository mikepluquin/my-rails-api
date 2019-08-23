class PostSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :body, :likes
end

class Conversation < ApplicationRecord
  belongs_to :recipient, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :user_1_id, :scope => :user_2_id
end

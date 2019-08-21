class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validate :user_in_conversation

  private

  def user_in_conversation
    if user.present? && conversation.present? && (user != conversation.sender && user != conversation.recipient)
      errors.add(:global, "user must be in the conversation")
    end
  end
end

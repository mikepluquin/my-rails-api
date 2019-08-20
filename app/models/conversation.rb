class Conversation < ApplicationRecord
  belongs_to :recipient, class_name: 'User'
  belongs_to :sender, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: :recipient_id
  validate :different_recipient_and_sender

  private

  def different_recipient_and_sender
    if recipient.present? && sender.present? && recipient.id == sender.id
      errors.add(:global, "sender cannot be the same as recipient")
    end
  end
end

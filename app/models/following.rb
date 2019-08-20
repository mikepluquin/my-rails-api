class Following < ApplicationRecord
  belongs_to :followed, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  validates_uniqueness_of :followed_id, scope: :follower_id
  validate :different_follower_and_followed

  private

  def different_follower_and_followed
    if follower.present? && followed.present? && follower.id == followed.id
      errors.add(:global, "followed cannot be the same as follower")
    end
  end

end

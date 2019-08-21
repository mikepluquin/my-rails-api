require 'rails_helper'

RSpec.describe Following, type: :model do
  describe 'db columns' do
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }

    it { is_expected.to have_db_index(:followed_id) }
    it { is_expected.to have_db_index(:follower_id) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:followed).class_name('User') }
    it { is_expected.to belong_to(:follower).class_name('User') }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:followed_id).scoped_to(:follower_id) }

    let(:follower) { create (:user) }
    let(:followed) { create (:user) }

    context 'different follower and followed' do
      before do
        subject.follower = follower
        subject.followed = followed
      end
      it { is_expected.to be_valid }
    end

    context 'same follower and followed' do
      before do
        subject.follower = follower
        subject.followed = follower
      end
      it { is_expected.to_not be_valid }
    end
  end
end

require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe 'db columns' do
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }

    it { is_expected.to have_db_index(:recipient_id) }
    it { is_expected.to have_db_index(:sender_id) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:messages).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:sender_id).scoped_to(:recipient_id) }

    let(:recipient) { create (:user) }
    let(:sender) { create (:user) }

    context 'different recipient and sender' do
      before do
        subject.recipient = recipient
        subject.sender = sender
      end
      it { is_expected.to be_valid }
    end

    context 'same recipient and sender' do
      before do
        subject.recipient = recipient
        subject.sender = recipient
      end
      it { is_expected.to_not be_valid }
    end
  end

end

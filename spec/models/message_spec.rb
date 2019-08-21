require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'db columns' do
    it { is_expected.to have_db_column(:read).of_type(:boolean) }
    it { is_expected.to have_db_column(:body).of_type(:text) }

    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }

    it { is_expected.to have_db_index(:conversation_id) }
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:conversation) }
  end

  describe 'validations' do
    let(:sender) { create (:user) }
    let(:recipient) { create (:user) }
    let(:conversation) { create (:conversation) }

    context 'user is not from the conversation' do
      before do
        conversation.sender = sender
        conversation.recipient = recipient
        subject.conversation = conversation
        subject.user = create(:user)
      end
      it { is_expected.to_not be_valid }
    end

    context 'user is from the conversation' do
      before do
        conversation.sender = sender
        conversation.recipient = recipient
        subject.conversation = conversation
        subject.user = sender
      end
      it { is_expected.to be_valid }
    end
  end
end

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
  end

end

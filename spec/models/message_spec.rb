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
end

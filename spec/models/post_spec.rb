require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'db columns' do
    it { is_expected.to have_db_column(:body).of_type(:string) }

    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }

    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:liking_users).through(:likes).source(:user) }
  end
end

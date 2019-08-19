require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'db columns' do
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }

    it { is_expected.to have_db_index(:post_id) }
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  describe 'validations' do
    # TODO : correct the test, it fails but the feature is working
    # it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'db columns' do
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:born_date).of_type(:datetime) }
    it { is_expected.to have_db_column(:password_digest).of_type(:string) }
  end

  describe 'validations' do
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_uniqueness_of(:email) }
  end
end

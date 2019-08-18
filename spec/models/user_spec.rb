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
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to have_secure_password }

    it { is_expected.to validate_uniqueness_of(:email) }

    it { is_expected.to validate_confirmation_of(:password) }

    it { is_expected.to validate_length_of(:password).is_at_least(6) }

    it { is_expected.to allow_value('last_name.first_name123@mail.com').for(:email) }
    it { is_expected.to_not allow_value('last_name.first_name').for(:email) }
    it { is_expected.to_not allow_value('@mail.com').for(:email) }
    it { is_expected.to_not allow_value('last_name.com').for(:email) }
    it { is_expected.to_not allow_value(nil).for(:email) }
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'db columns' do
    it { is_expected.to have_db_column(:username).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:born_date).of_type(:datetime) }
    it { is_expected.to have_db_column(:password_digest).of_type(:string) }

    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:liked_posts).through(:likes).source(:post) }

    it { is_expected.to have_many(:followings_in).dependent(:destroy).with_foreign_key(:followed_id).class_name('Following') }
    it { is_expected.to have_many(:followings_out).dependent(:destroy).with_foreign_key(:follower_id).class_name('Following') }
    it { is_expected.to have_many(:followers).through(:followings_in) }
    it { is_expected.to have_many(:followeds).through(:followings_out) }

    it { is_expected.to have_many(:conversations_sent).class_name('Conversation') }
    it { is_expected.to have_many(:conversations_received).class_name('Conversation') }
    it { is_expected.to have_many(:messages).dependent(:destroy) }

  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
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

require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:user) { create(:user) }

  describe "POST #login" do
    context "with incorrect credentials" do
      before { get :login, params: { email: 'invalidmail', password: 'invalidpassword' } }
      it { is_expected.to respond_with(401) }
    end

    context "with correct credentials" do
      before { get :login, params: { email: user.email, password: user.password } }
      it { is_expected.to respond_with(200) }
    end
  end
end

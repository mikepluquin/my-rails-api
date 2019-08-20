require 'rails_helper'

RSpec.describe "authentication requests", type: :request do
  let(:user) { create(:user) }

  describe "authenticate" do
    context "with incorrect credentials" do
      before { post auth_login_path, params: { email: 'invalidmail', password: 'invalidpassword' } }
      it_should_behave_like "an unauthorized request"
    end

    context "with correct credentials" do
      before { post auth_login_path, params: { email: user.email, password: user.password } }
      it { expect(response.body).to include 'token' }
      it { expect(response.body).to include 'id' }
      it { expect(response.body).to include 'exp' }
      it_should_behave_like "a success request"
    end
  end
end

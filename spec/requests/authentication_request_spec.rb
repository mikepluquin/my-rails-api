require 'rails_helper'

RSpec.describe "authentication requests", type: :request do
  let(:user) { create(:user) }
  let(:valid_params) { { user: {
    first_name: 'firstname',
    last_name: 'lastname',
    email: 'test@mail.com',
    password: 'password'
  } } }

  describe "login" do
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

  describe "register" do
    context "with invalid params" do
      let(:params) { { user: { first_name: 'firstname' } } }
      before { post auth_register_path, params: params }
      it_should_behave_like "an unprocessable entity request"
    end

    context "with valid params" do
      before { post auth_register_path, params: valid_params }
      it_should_behave_like "a created request"
      it { expect(response.body).to include valid_params[:user][:email] }
      it { expect(response.body).to include 'token' }
      it { expect(response.body).to include 'id' }
      it { expect(response.body).to include 'exp' }
    end
  end
end

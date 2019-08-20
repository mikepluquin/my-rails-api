require 'rails_helper'

RSpec.describe "users requests", type: :request do
  let!(:users) { create_list(:user, 10) }
  let!(:user) { create(:user) }
  let!(:valid_params) { { user: {
      first_name: 'firstname',
      last_name: 'lastname',
      email: 'test@mail.com',
      password: 'password'
  } } }

  context do 'user not logged in'
    describe "get users" do
      before { get users_path }
      it_should_behave_like "an unauthorized request"
    end

    describe "get user" do
      before { get user_path(id: user.id) }
      it_should_behave_like "an unauthorized request"
    end

    describe "create user" do
      context "with invalid params" do
        let(:params) { { user: { first_name: 'firstname' } } }
        before { post users_path, params: params }
        it_should_behave_like "an unprocessable entity request"
      end

      context "with valid params" do
        before { post users_path, params: valid_params }
        it_should_behave_like "a created request"
        it { expect(response.body).to include valid_params[:user][:email] }
      end
    end

    describe "update user" do
      before { patch user_path(id: user.id) }
      it_should_behave_like "an unauthorized request"
    end

    describe "delete user" do
      before { delete user_path(id: user.id) }
      it_should_behave_like "an unauthorized request"
    end
  end

  context 'user logged in' do
    describe "get users" do
      before { get users_path, headers: authenticated_header(user) }

      it_should_behave_like "a success request"
      it { expect(response.body).to include user.to_json }
      it { expect(response.body).to include users.last.to_json }
      it { expect(response.body).to include users.first.to_json }
      let(:json_response) { JSON.parse(response.body)}
      it "should return all users" do
        expect(json_response.size).to eq(11)
      end
    end

    describe "get user" do
      before { get user_path(id: user.id), headers: authenticated_header(user) }
      it_should_behave_like "a success request"
      it { expect(response.body).to include user.to_json }
    end

    describe "update user" do
      context do "current user is the target user"
        before { patch user_path(id: user.id), params: valid_params, headers: authenticated_header(user) }
        it_should_behave_like "a success request"
        it { expect(response.body).to include valid_params[:user][:email] }
      end
      context do "current user is not the target user"
        before { patch user_path(id: users.first.id), params: valid_params, headers: authenticated_header(user) }
        it { expect(response).to have_http_status(:forbidden) }
      end
    end

    describe "delete user" do
      context do "current user is the target user"
        before { delete user_path(id: user.id), headers: authenticated_header(user) }
        it { expect(User.where(id: user.id)).to_not exist }
        it { expect(response).to have_http_status(:no_content) }
      end
      context do "current user is not the target user"
        before { delete user_path(id: users.first.id), headers: authenticated_header(user) }
        it { expect(User.where(id: users.first.id)).to exist }
        it { expect(response).to have_http_status(:forbidden) }
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "users requests", type: :request do
  let(:users) { create_list(:user, 10) }
  let(:user) { create(:user) }

  context do 'user not logged in'
    describe "get users" do
      before { get users_path }

      it { expect(response.content_type).to eq("application/json") }
      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(response.body).to include 'errors' }
    end

    describe "get user" do
      before { get user_path(id: user.id) }

      it { expect(response.content_type).to eq("application/json") }
      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(response.body).to include 'errors' }
    end

    describe "create user" do
      context "with invalid params" do
        let(:params) { { user: { first_name: 'firstname' } } }
        before { post users_path, params: params }

        it { expect(response.content_type).to eq("application/json") }
        it { expect(response).to have_http_status(:unprocessable_entity) }
        it { expect(response.body).to include 'errors' }
      end

      context "with valid params" do
        let(:params) { { user: {
            first_name: 'firstname',
            last_name: 'lastname',
            email: 'test@mail.com',
            password: 'password'
         } } }
        before { post users_path, params: params }

        it { expect(response.content_type).to eq("application/json") }
        it { expect(response).to have_http_status(:created) }
        it { expect(response.body).to include params[:user][:email] }
      end
    end

    describe "update user" do
      before { put user_path(id: user.id) }

      it { expect(response.content_type).to eq("application/json") }
      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(response.body).to include 'errors' }
    end

    describe "update user" do
      before { patch user_path(id: user.id) }

      it { expect(response.content_type).to eq("application/json") }
      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(response.body).to include 'errors' }
    end

    describe "delete user" do
      before { delete user_path(id: user.id) }

      it { expect(response.content_type).to eq("application/json") }
      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(response.body).to include 'errors' }
    end
  end

  context 'user logged in' do
    describe "get users" do
      before do
        users # force creations
        user
        get users_path, headers: authenticated_header(user)
      end

      it { expect(response.content_type).to eq("application/json") }
      it { expect(response).to have_http_status(:success) }
      it { expect(response.body).to include user.to_json }
      it { expect(response.body).to include users.last.to_json }
      it { expect(response.body).to include users.first.to_json }
      let(:json_response) { JSON.parse(response.body)}
      it "should return all users" do
        expect(json_response.size).to eq(11)
      end
    end

    # describe "PUT #update" do
    #   before do
    #     authenticated_header(request, user)
    #     put :update, params: { id: user.id, password: 'newpassword' }
    #   end
    #
    #   it { is_expected.to respond_with(204) }
    # end
  end
end

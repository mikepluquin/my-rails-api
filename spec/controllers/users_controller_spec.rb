require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context do 'user not logged in'
    describe "GET #index" do
      before { get :index }
      it { is_expected.to respond_with(401) }
    end

    describe "GET #show" do
      let(:user) { create(:user) }
      before { get :show, params: { id: user.id } }
      it { is_expected.to respond_with(401) }
    end

    # describe "POST #create" do
    #   before { post :create }
    #   it { is_expected.to respond_with(401) }
    # end

    describe "PUT #update" do
      let(:user) { create(:user) }
      before { put :update, params: { id: user.id } }
      it { is_expected.to respond_with(401) }
    end

    describe "PATCH #update" do
      let(:user) { create(:user) }
      before { patch :update, params: { id: user.id } }
      it { is_expected.to respond_with(401) }
    end

    describe "DELETE #destroy" do
      let(:user) { create(:user) }
      before { delete :destroy, params: { id: user.id } }
      it { is_expected.to respond_with(401) }
    end
  end

  context 'user logged in' do
    describe "GET #index" do
      let (:users) { create_list(:user, 10) }

      before do
        authenticated_header(request, users.first)
        get :index
      end

      it { is_expected.to respond_with(200) }
      it "should return all users" do
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(10)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:users) { create_list(:user, 10) }
  let(:user) { create(:user) }

  context do 'user not logged in'
    describe "GET #index" do
      before { get :index }
      it { is_expected.to respond_with(401) }
    end

    describe "GET #show" do
      before { get :show, params: { id: user.id } }
      it { is_expected.to respond_with(401) }
    end

    describe "POST #create" do
      context "with invalid params" do
        before { post :create, params: { first_name: 'test' } }
        it { is_expected.to respond_with(422) }
      end
    end

    describe "PUT #update" do
      before { put :update, params: { id: user.id } }
      it { is_expected.to respond_with(401) }
    end

    describe "PATCH #update" do
      before { patch :update, params: { id: user.id } }
      it { is_expected.to respond_with(401) }
    end

    describe "DELETE #destroy" do
      before { delete :destroy, params: { id: user.id } }
      it { is_expected.to respond_with(401) }
    end
  end

  context 'user logged in' do
    describe "GET #index" do
      before do
        users # force creations
        user
        authenticated_header(request, user)
        get :index
      end

      it { is_expected.to respond_with(200) }
      it "should return all users" do
        json_response = JSON.parse(response.body)
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

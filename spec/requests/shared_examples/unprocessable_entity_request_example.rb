require "set"

RSpec.shared_examples "an unprocessable entity request" do
  it { expect(response.content_type).to eq("application/json") }
  it { expect(response).to have_http_status(:unprocessable_entity) }
  it { expect(response.body).to include 'errors' }
end

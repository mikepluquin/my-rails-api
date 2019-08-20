require "set"

RSpec.shared_examples "an unauthorized request" do
  it { expect(response.content_type).to eq("application/json") }
  it { expect(response).to have_http_status(:unauthorized) }
  it { expect(response.body).to include 'error' }
end

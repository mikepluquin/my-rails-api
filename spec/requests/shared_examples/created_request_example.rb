require "set"

RSpec.shared_examples "a created request" do
  it { expect(response.content_type).to eq("application/json") }
  it { expect(response).to have_http_status(:created) }
end

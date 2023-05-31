# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V2::SchoolsController", type: :request do
  describe "GET #index" do
    let!(:api_key) { ApiKey.create }
    let!(:school)  { create(:school) }
    let(:json_response) { JSON.parse(response.body) }

    before {
      headers = { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" }
      get "/api/v2/schools", headers: headers
    }

    it { expect(response.status).to eq(200) }
    it { expect(json_response["schools"].length).to eq(1) }
  end
end

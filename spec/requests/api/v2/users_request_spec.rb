# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V2::UsersController", type: :request do
  describe "POST #create" do
    let!(:api_key) { ApiKey.create }
    let!(:high_school) { create(:high_school) }
    let!(:params) {
      {
        full_name: "Sokly",
        sex: "female",
        date_of_birth: 20.years.ago.to_date,
        phone_number: "011222333",
        grade: "other",
        other_grade: "other_occupation",
        class_group: User.class_groups.keys.sample,
        high_school_id: high_school.code,
        district_id: high_school.district_id,
        device_id: "0ebf40b3",
        device_type: "mobile",
        device_os: "android",
        app_version: 161
      }
    }
    let(:json_response) { JSON.parse(response.body) }

    before {
      headers = { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" }
      post "/api/v2/users", headers: headers, params: { user: params }
    }

    it { expect(response.status).to eq(201) }
    it { expect(User.count).to eq(1) }
    it { expect(json_response["full_name"]).to eq("Sokly") }
  end
end

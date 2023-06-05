# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V2::UsersController", type: :request do
  describe "POST #create" do
    let!(:api_key) { ApiKey.create }
    let!(:middle_school) { create(:middle_school) }
    let!(:params) {
      {
        full_name: "Sokly",
        sex: "female",
        date_of_birth: 20.years.ago.to_date,
        phone_number: "011222333",
        grade: User::GRADES.sample,
        class_group: User.class_groups.keys.sample,
        middle_school_id: middle_school.id,
        commune_code: middle_school.commune_id
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
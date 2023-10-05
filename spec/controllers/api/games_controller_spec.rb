# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::GamesController, type: :controller do
  include AuthHelper

  describe "POST game#create" do
    let!(:user) { create(:user, uuid: "7a8a2643-6d12-419e-8604-e39239fc33a3") }
    let!(:characteristic) { create(:characteristic) }
    let!(:career) { create(:career, code: "car_sci_0001", categorizable: characteristic) }

    let(:valid_attributes) {
      {
        "data"=>"{\"version\":\"android 1.0\",\"uuid\":\"8669cfb0-c73f-4195-a64a-4f05a7633f29\",\"characteristic_id\":#{characteristic.id},\"characteristic_entries\":[\"ចូលចិត្តធ្វើការជាមួយ នឹងបច្ចេកវិទ្យា និង គ្រឿងម៉ាស៊ីន\"],\"most_favorable_job_code\":\"car_sci_0001\",\"reason\":\"Test\",\"voice_record\":\"\",\"created_at\":\"2019-04-25T06:54:12.675Z\",\"subject_attributes\":{\"uuid\":\"2078f742-d060-4bed-8602-eab1d3d51e63\",\"khmer_reading\":\"មធ្យម\"},\"user_uuid\":\"7a8a2643-6d12-419e-8604-e39239fc33a3\",\"personal_understandings_attributes\":[{\"uuid\":\"00f6b96d-9a8e-43be-b125-d0e57fb61a1a\",\"user_uuid\":\"7a8a2643-6d12-419e-8604-e39239fc33a3\",\"are_you_going_to_study_till_grade12\":\"Yes\",\"are_your_parents_allow_you_to_study_till_grade12\":\"Yes\",\"have_you_ever_thought_of_career\":\"Yes\",\"career_name\":null,\"how_to_reach_career_goal\":null,\"does_parents_agree_with\":\"Yes\",\"ever_talked_with_anyone_about_career\":\"ឳពុកម្តាយ;បងប្អូន;ក្រុមប្រឹក្សាកុមារ\",\"how_to_reach_job_vacancy\":null,\"score\":\"13\"}],\"career_games_attributes\":[{\"career_code\":\"car_sci_0001\",\"is_goal\":true}]}"
      }
    }

    let(:invalid_attributes) {
      {
        "data"=>"{\"version\":\"android 1.0\",\"uuid\":\"8669cfb0-c73f-4195-a64a-4f05a7633f29\",\"characteristic_id\":#{characteristic.id},\"characteristic_entries\":[\"ចូលចិត្តធ្វើការជាមួយ នឹងបច្ចេកវិទ្យា និង គ្រឿងម៉ាស៊ីន\"],\"most_favorable_job_code\":\"car_sci_0001\",\"reason\":\"Test\",\"voice_record\":\"\",\"created_at\":\"2019-04-25T06:54:12.675Z\",\"subject_attributes\":{\"uuid\":\"2078f742-d060-4bed-8602-eab1d3d51e63\",\"khmer_reading\":\"មធ្យម\"},\"user_uuid\":\"invalid_uuid\",\"personal_understandings_attributes\":[{\"uuid\":\"00f6b96d-9a8e-43be-b125-d0e57fb61a1a\",\"user_uuid\":\"7a8a2643-6d12-419e-8604-e39239fc33a3\",\"are_you_going_to_study_till_grade12\":\"Yes\",\"are_your_parents_allow_you_to_study_till_grade12\":\"Yes\",\"have_you_ever_thought_of_career\":\"Yes\",\"career_name\":null,\"how_to_reach_career_goal\":null,\"does_parents_agree_with\":\"Yes\",\"ever_talked_with_anyone_about_career\":\"ឳពុកម្តាយ;បងប្អូន;ក្រុមប្រឹក្សាកុមារ\",\"how_to_reach_job_vacancy\":null,\"score\":\"13\"}],\"career_games_attributes\":[{\"career_code\":\"car_sci_0001\",\"is_goal\":true}]}"
      }
    }

    before(:each) do
      http_login
    end

    context "with valid attributes" do
      it "create a new game with success status" do
        expect { post :create, params: valid_attributes }.to change(Game, :count).by(1)
        expect { post :create, params: valid_attributes }.to change(CareerGame, :count).by(1)
        expect { post :create, params: valid_attributes }.to change(Subject, :count).by(1)
        expect { post :create, params: valid_attributes }.to change(PersonalUnderstanding, :count).by(1)
      end
    end

    context "with invalid attributes with invaid uuid" do
      it "create a new game with success status" do
        expect { post :create, params: invalid_attributes }.to change(Game, :count).by(0)
      end
    end
  end
end

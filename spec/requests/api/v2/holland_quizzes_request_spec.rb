# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V2::HollandQuizzesController", type: :request do
  describe "POST #create" do
    let!(:api_key) { ApiKey.create }
    let!(:user)    { create(:user) }

    let!(:headers)  { { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" } }

    let(:params)   {
      {
        user_id: user.id,
        quizzed_at: DateTime.yesterday.to_s
      }
    }
    let(:json_response) { JSON.parse(response.body) }

    before {
      post "/api/v2/holland_quizzes", headers: headers, params: { holland_quiz: params }
    }

    it "add a holland_quiz job" do
      expect(HollandQuizJob.jobs.count).to eq(1)
    end

    it "render status created" do
      expect(response.status).to eq(201)
    end
  end

  describe "PUT #update" do
    let!(:api_key) { ApiKey.create }
    let!(:user)    { create(:user) }
    let!(:majors)  { create_list(:major, 3) }
    let!(:jobs)    { create_list(:job, 3) }
    let!(:self_understanding_question) { create(:self_understanding_question, :with_options) }
    let!(:holland_question) { create(:holland_question) }
    let!(:quiz)    { create(:holland_quiz, user: user) }
    let(:params)   {
      {
        user_id: user.id,
        quizzed_at: DateTime.yesterday.to_s,
        finished_at: (DateTime.yesterday + 10.minutes).to_s,
        self_understanding_responses_attributes: [
          {
            self_understanding_question_code: self_understanding_question.code,
            value: self_understanding_question.options.first.value
          }
        ],
        self_understanding_score: rand(8),
        holland_scores_attributes: [
          { personality_type: "R", score: 40 },
          { personality_type: "I", score: 30 }
        ],
        holland_responses_attributes: [
          {
            holland_question_code: holland_question.code,
            value: rand(1..5)
          }
        ],
        holland_major_responses_attributes: [
          { major_code: majors[0].code, selected: true },
          { major_code: majors[1].code, selected: false },
          { major_code: majors[2].code, selected: false }
        ],
        holland_job_responses_attributes: [
          { job_code: jobs[0].code, selected: true },
          { job_code: jobs[1].code, selected: false },
          { job_code: jobs[2].code, selected: false }
        ]
      }
    }
    let(:headers)  { { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" } }

    it "add a holland_quiz job" do
      expect {
        put "/api/v2/holland_quizzes/#{quiz.id}", headers: headers, params: { holland_quiz: params }
      }.to change(HollandQuizJob.jobs, :size).by(1)
    end
  end
end

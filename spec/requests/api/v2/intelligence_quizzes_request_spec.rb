# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V2::IntelligenceQuizzesController", type: :request do
  describe "POST #create" do
    let!(:api_key) { ApiKey.create }
    let!(:user)    { create(:user) }
    let!(:intelligence_question) { create(:intelligence_question) }
    let!(:intelligence_category) { create(:intelligence_category) }
    let!(:headers)  { { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" } }

    let(:params)   {
      {
        user_id: user.id,
        quizzed_at: DateTime.yesterday.to_s,
        finished_at: (DateTime.yesterday + rand(20..30).minutes).to_s,
        intelligence_scores_attributes: [
          { intelligence_category_code: intelligence_category.code, score: 40 },
        ],
        intelligence_responses_attributes: [
          {
            intelligence_question_code: intelligence_question.code,
            value: rand(1..4)
          }
        ]
      }
    }
    let(:json_response) { JSON.parse(response.body) }

    before {
      post "/api/v2/intelligence_quizzes", headers: headers, params: { intelligence_quiz: params }
    }

    it "add a intelligence_quiz job" do
      expect(IntelligenceQuizJob.jobs.count).to eq(1)
    end

    it "render status created" do
      expect(response.status).to eq(201)
    end
  end

  describe "PUT #update" do
    let!(:api_key) { ApiKey.create }
    let!(:user)    { create(:user) }
    let!(:quiz)    { create(:intelligence_quiz, user: user) }
    let(:params)   { { user_id: user.id, quizzed_at: DateTime.yesterday.to_s } }
    let(:headers)  { { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" } }

    it "add a holland_quiz job" do
      expect {
        put "/api/v2/intelligence_quizzes/#{quiz.id}", headers: headers, params: { intelligence_quiz: params }
      }.to change(IntelligenceQuizJob.jobs, :size).by(1)
    end
  end
end

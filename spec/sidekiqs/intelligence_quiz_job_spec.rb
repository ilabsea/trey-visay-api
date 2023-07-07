# frozen_string_literal: true

require "rails_helper"

RSpec.describe IntelligenceQuizJob, type: :job do
  describe "perfom" do
    let!(:user) { create(:user) }
    let!(:quiz) { create(:intelligence_quiz, user: user) }
    let!(:intelligence_question) { create(:intelligence_question) }
    let!(:intelligence_category) { create(:intelligence_category) }

    let(:params)   {
      {
        user_id: user.id,
        quizzed_at: DateTime.yesterday.to_s,
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

    before {
      subject.perform(quiz.id, params.as_json)
    }

    it "update quiz" do
      expect(quiz.intelligence_scores.length).to eq(1)
      expect(quiz.intelligence_responses.length).to eq(1)
    end
  end
end

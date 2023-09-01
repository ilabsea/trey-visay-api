# frozen_string_literal: true

require "rails_helper"

RSpec.describe HollandQuizJob, type: :job do
  describe "perfom" do
    let!(:user) { create(:user) }
    let!(:quiz) { create(:holland_quiz, user: user) }
    let!(:college_majors) { create_list(:college_major, 3) }
    let!(:jobs) { create_list(:job, 3) }
    let!(:self_understanding_question) { create(:self_understanding_question, :with_options) }
    let!(:holland_question) { create(:holland_question) }

    let(:params)   {
      {
        user_id: user.id,
        quizzed_at: DateTime.yesterday.to_s,
        self_understanding_responses_attributes: [
          {
            self_understanding_question_code: self_understanding_question.code,
            value: self_understanding_question.options.first.value
          }
        ],
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
          { college_major_code: college_majors[0].code, selected: true },
          { college_major_code: college_majors[1].code, selected: false },
          { college_major_code: college_majors[2].code, selected: false }
        ],
        holland_job_responses_attributes: [
          { job_code: jobs[0].code, selected: true },
          { job_code: jobs[1].code, selected: false },
          { job_code: jobs[2].code, selected: false }
        ]
      }
    }

    before {
      subject.perform(quiz.id, params.as_json)
    }

    it "update quiz" do
      expect(quiz.self_understanding_responses.length).to eq(1)
      expect(quiz.holland_scores.length).to eq(2)
      expect(quiz.holland_responses.length).to eq(1)
      expect(quiz.holland_major_responses.length).to eq(3)
      expect(quiz.holland_job_responses.length).to eq(3)
    end
  end
end
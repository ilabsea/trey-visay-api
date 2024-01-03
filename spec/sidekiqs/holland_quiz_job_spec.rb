# frozen_string_literal: true

require "rails_helper"

RSpec.describe HollandQuizJob, type: :job do
  describe "perfom" do
    let!(:user) { create(:user) }
    let!(:quiz) { create(:holland_quiz, user: user) }
    let!(:majors) { create_list(:major, 3) }
    let!(:jobs) { create_list(:job, 3) }
    let!(:self_understanding_question) { create(:self_understanding_question, :with_options) }
    let!(:holland_question) { create(:holland_question) }

    let(:params)   {
      {
        user_id: user.id,
        quizzed_at: DateTime.yesterday.to_s,
        self_understanding_score: 5,
        self_understanding_responses_attributes: [
          {
            self_understanding_question_code: self_understanding_question.code,
            value: self_understanding_question.options.first.value
          }
        ],
        holland_scores_attributes: [
          { personality_type: "R", score: 40 },
          { personality_type: "I", score: 30 },
          { personality_type: "C", score: 50 },
          { personality_type: "A", score: 10 },
          { personality_type: "E", score: 45 },
          { personality_type: "S", score: 20 }
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

    before {
      subject.perform(quiz.id, params.as_json)
    }

    it "updates quiz" do
      expect(quiz.self_understanding_responses.length).to eq(1)
      expect(quiz.holland_scores.pluck(:personality_type, :display_order)).to eq([["C", 1], ["E", 2], ["R", 3], ["I", 4], ["S", 5], ["A", 6]])
      expect(quiz.holland_responses.length).to eq(1)
      expect(quiz.holland_major_responses.length).to eq(3)
      expect(quiz.holland_job_responses.length).to eq(3)
      expect(user.reload.is_self_understanding).to be_truthy
    end
  end
end

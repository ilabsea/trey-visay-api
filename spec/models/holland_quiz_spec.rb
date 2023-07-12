# frozen_string_literal: true

# == Schema Information
#
# Table name: quizzes
#
#  id                       :string(255)      not null, primary key
#  user_id                  :integer
#  quizzed_at               :datetime
#  type                     :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  finished_at              :datetime
#  self_understanding_score :integer
#
require "rails_helper"

RSpec.describe HollandQuiz, type: :model do
  it { is_expected.to have_many(:self_understanding_responses) }
  it { is_expected.to have_many(:holland_responses) }
  it { is_expected.to have_many(:holland_major_responses) }
  it { is_expected.to have_many(:holland_job_responses) }
  it { is_expected.to have_many(:holland_scores) }

  describe "#after_create, set_if_user_can_complete_grade_twelve" do
    let!(:user) { create(:user) }
    let!(:q1) { create(:self_understanding_question, :q1) }
    let!(:q2) { create(:self_understanding_question, :q2) }

    context "either question 1 or 2 has response value with 'unsure'" do
      let(:quiz) {
        create(:holland_quiz,
          {
            user_id: user.id,
            quizzed_at: DateTime.yesterday.to_s,
            finished_at: (DateTime.yesterday + 10.minutes).to_s,
            self_understanding_responses_attributes: [
              {
                self_understanding_question_code: q1.code,
                value: "unsure"
              },
              {
                self_understanding_question_code: q2.code,
                value: "grade12"
              }
            ]
          }
        )
      }

      it "set user can complete grade twelve to false" do
        expect(quiz.user.is_complete_grade_twelve).to be_falsey
      end
    end

    context "both question 1 and 2 has no response value with 'unsure'" do
      let(:quiz) {
        create(:holland_quiz,
          {
            user_id: user.id,
            quizzed_at: DateTime.yesterday.to_s,
            finished_at: (DateTime.yesterday + 10.minutes).to_s,
            self_understanding_responses_attributes: [
              {
                self_understanding_question_code: q1.code,
                value: "grade12"
              },
              {
                self_understanding_question_code: q2.code,
                value: "grade12"
              }
            ]
          }
        )
      }

      it "set user can complete grade twelve to true" do
        expect(quiz.user.is_complete_grade_twelve).to be_truthy
      end
    end
  end
end

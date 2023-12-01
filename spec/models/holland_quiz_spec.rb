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
#  display_order            :integer
#
require "rails_helper"

RSpec.describe HollandQuiz, type: :model do
  it { is_expected.to have_many(:self_understanding_responses).dependent(:destroy) }
  it { is_expected.to have_many(:holland_responses).dependent(:destroy) }
  it { is_expected.to have_many(:holland_major_responses).dependent(:destroy) }
  it { is_expected.to have_many(:holland_job_responses).dependent(:destroy) }
  it { is_expected.to have_many(:holland_scores).dependent(:destroy) }

  describe "#after_create, set potential_drop_off" do
    let!(:user) { create(:user) }
    let!(:q1) { create(:self_understanding_question, :q1) }
    let!(:q2) { create(:self_understanding_question, :q2) }

    let(:param) {
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
    }
    context "either question 1 or 2 has response value with 'unsure'" do
      let(:quiz) { create(:holland_quiz, param) }

      it "set user can complete grade twelve to false" do
        expect(quiz.user.potential_drop_off).to be_truthy
      end
    end

    context "user's potential_drop_off is already set" do
      let!(:user) { create(:user, potential_drop_off: false) }
      let!(:quiz) { create(:holland_quiz, param) }

      it "set user can complete grade twelve to false" do
        expect(quiz.user.potential_drop_off).to be_falsey
      end
    end

    context "both question 1 and 2 has no response value with 'unsure'" do
      let(:quiz) {
        create(:holland_quiz,
          param.merge({
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
          })
        )
      }

      it "set user can complete grade twelve to true" do
        expect(quiz.user.potential_drop_off).to be_falsey
      end
    end
  end
end

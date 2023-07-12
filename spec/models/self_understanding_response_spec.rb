# frozen_string_literal: true

# == Schema Information
#
# Table name: self_understanding_responses
#
#  id                               :string(255)      not null, primary key
#  holland_quiz_id                  :string(255)
#  self_understanding_question_id   :string(255)
#  self_understanding_question_code :string(255)
#  value                            :string(255)
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
require "rails_helper"

RSpec.describe SelfUnderstandingResponse, type: :model do
  it { is_expected.to belong_to(:quiz).class_name("HollandQuiz").with_foreign_key(:holland_quiz_id) }
  it { is_expected.to belong_to(:question).class_name("SelfUnderstandingQuestion").with_foreign_key(:self_understanding_question_id) }
  it { is_expected.to have_one(:user).through(:quiz) }
end

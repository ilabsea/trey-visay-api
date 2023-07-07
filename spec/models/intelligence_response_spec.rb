# frozen_string_literal: true

# == Schema Information
#
# Table name: intelligence_responses
#
#  id                         :string(255)      not null, primary key
#  intelligence_quiz_id       :string(255)
#  intelligence_question_id   :string(255)
#  intelligence_question_code :string(255)
#  value                      :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
require "rails_helper"

RSpec.describe IntelligenceResponse, type: :model do
  it { is_expected.to belong_to(:quiz).class_name("IntelligenceQuiz").with_foreign_key(:intelligence_quiz_id) }
  it { is_expected.to belong_to(:question).class_name("IntelligenceQuestion").with_foreign_key(:intelligence_question_id) }
end

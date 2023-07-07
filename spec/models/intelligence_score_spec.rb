# frozen_string_literal: true

# == Schema Information
#
# Table name: intelligence_scores
#
#  id                       :string(255)      not null, primary key
#  intelligence_quiz_id     :string(255)
#  intelligence_category_id :string(255)
#  score                    :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
require "rails_helper"

RSpec.describe IntelligenceScore, type: :model do
  it { is_expected.to belong_to(:quiz).class_name("IntelligenceQuiz").with_foreign_key(:intelligence_quiz_id) }
  it { is_expected.to belong_to(:intelligence_category) }
end

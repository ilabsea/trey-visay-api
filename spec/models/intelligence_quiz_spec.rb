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

RSpec.describe IntelligenceQuiz, type: :model do
  it { is_expected.to have_many(:intelligence_responses) }
  it { is_expected.to have_many(:intelligence_scores) }
end

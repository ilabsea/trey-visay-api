# frozen_string_literal: true

# == Schema Information
#
# Table name: quizzes
#
#  id         :string(255)      not null, primary key
#  user_id    :integer
#  quizzed_at :datetime
#  type       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe HollandQuiz, type: :model do
  it { is_expected.to have_many(:self_understanding_responses) }
  it { is_expected.to have_many(:holland_responses) }
  it { is_expected.to have_many(:holland_major_responses) }
  it { is_expected.to have_many(:holland_job_responses) }
  it { is_expected.to have_many(:holland_scores) }
end

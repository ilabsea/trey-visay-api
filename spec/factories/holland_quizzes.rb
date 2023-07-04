# frozen_string_literal: true

# == Schema Information
#
# Table name: holland_quizzes
#
#  id                        :string(255)      not null, primary key
#  user_id                   :integer
#  personality_type_results  :string(255)
#  college_major_id          :string(255)
#  job_id                    :string(255)
#  quizzed_at                :datetime
#  selected_college_major_at :datetime
#  selected_job_at           :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
FactoryBot.define do
  factory :holland_quiz do
    user
    quizzed_at { Time.now }
  end
end

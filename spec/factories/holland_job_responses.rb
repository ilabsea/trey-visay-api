# == Schema Information
#
# Table name: holland_job_responses
#
#  id              :string(255)      not null, primary key
#  holland_quiz_id :string(255)
#  job_id          :string(255)
#  selected        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :holland_job_response do
    
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: job_majors
#
#  id         :bigint(8)        not null, primary key
#  job_id     :string(255)
#  major_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :job_major do
  end
end

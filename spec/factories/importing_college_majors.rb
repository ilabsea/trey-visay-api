# frozen_string_literal: true

# == Schema Information
#
# Table name: importing_college_majors
#
#  id                     :bigint(8)        not null, primary key
#  college_major_id       :string(255)
#  college_major_batch_id :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
FactoryBot.define do
  factory :importing_college_major do
  end
end

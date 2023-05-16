# frozen_string_literal: true

# == Schema Information
#
# Table name: school_majors
#
#  id                   :bigint(8)        not null, primary key
#  major_id             :integer
#  school_id            :integer
#  department_id        :integer
#  school_department_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
FactoryBot.define do
  factory :school_major do
  end
end

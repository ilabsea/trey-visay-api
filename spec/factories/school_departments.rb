# frozen_string_literal: true

# == Schema Information
#
# Table name: school_departments
#
#  id            :bigint(8)        not null, primary key
#  school_id     :integer
#  department_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :school_department do
  end
end

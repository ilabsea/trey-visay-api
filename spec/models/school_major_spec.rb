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
require "rails_helper"

RSpec.describe SchoolMajor, type: :model do
  it { is_expected.to belong_to(:school_department) }
  it { is_expected.to belong_to(:school).optional }
  it { is_expected.to belong_to(:department).optional }
  it { is_expected.to belong_to(:major) }
end

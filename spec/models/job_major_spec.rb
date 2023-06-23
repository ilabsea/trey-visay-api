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
require "rails_helper"

RSpec.describe JobMajor, type: :model do
  it { is_expected.to belong_to(:job) }
  it { is_expected.to belong_to(:major) }
end

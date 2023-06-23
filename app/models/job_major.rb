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
class JobMajor < ApplicationRecord
  belongs_to :job
  belongs_to :major

  # Instant method
  def major_attributes=(hash)
    self.major = Major.find_or_create_by(name: hash[:name])
  end
end

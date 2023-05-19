# frozen_string_literal: true

# == Schema Information
#
# Table name: importing_jobs
#
#  id           :bigint(8)        not null, primary key
#  job_id       :string(255)
#  job_batch_id :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class ImportingJob < ApplicationRecord
  belongs_to :job
  belongs_to :job_batch

  accepts_nested_attributes_for :job
end

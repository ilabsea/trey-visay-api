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
class ImportingCollegeMajor < ApplicationRecord
  belongs_to :college_major
  belongs_to :college_major_batch

  accepts_nested_attributes_for :college_major
end

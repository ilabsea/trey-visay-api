# frozen_string_literal: true

# == Schema Information
#
# Table name: importing_middle_schools
#
#  id                     :bigint(8)        not null, primary key
#  middle_school_id       :string(255)
#  middle_school_batch_id :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class ImportingMiddleSchool < ApplicationRecord
  belongs_to :middle_school
  belongs_to :middle_school_batch

  accepts_nested_attributes_for :middle_school
end
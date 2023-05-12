# frozen_string_literal: true

# == Schema Information
#
# Table name: importing_schools
#
#  id              :bigint(8)        not null, primary key
#  school_id       :integer
#  school_batch_id :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class ImportingSchool < ApplicationRecord
  belongs_to :school
  belongs_to :school_batch

  accepts_nested_attributes_for :school
end

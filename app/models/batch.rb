# frozen_string_literal: true

# == Schema Information
#
# Table name: batches
#
#  id             :string(8)        not null, primary key
#  code           :string(255)
#  total_count    :integer          default(0)
#  valid_count    :integer          default(0)
#  new_count      :integer          default(0)
#  province_count :integer          default(0)
#  reference      :string(255)
#  creator_id     :integer
#  type           :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Batch < ApplicationRecord
  include BatchConcern

  # Association
  has_many :importing_items, dependent: :destroy
  has_many :videos, through: :importing_items, source: :itemable, source_type: "Video"
  has_many :college_majors, through: :importing_items, source: :itemable, source_type: "CollegeMajor"
  has_many :jobs, through: :importing_items, source: :itemable, source_type: "Job"
  has_many :holland_questions, through: :importing_items, source: :itemable, source_type: "HollandQuestion"
  has_many :schools, through: :importing_items, source: :itemable, source_type: "School"
  has_many :middle_schools, through: :importing_items, source: :itemable, source_type: "MiddleSchool"

  # Nested attributes
  accepts_nested_attributes_for :importing_items
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: school_batches
#
#  id             :string(8)        not null, primary key
#  code           :string(255)
#  total_count    :integer          default(0)
#  valid_count    :integer          default(0)
#  new_count      :integer          default(0)
#  province_count :integer          default(0)
#  reference      :string(255)
#  creator_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class SchoolBatch < ApplicationRecord
  include BatchConcern

  # Association
  has_many :importing_schools
  has_many :schools, through: :importing_schools

  # Nested attributes
  accepts_nested_attributes_for :importing_schools
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: middle_school_batches
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
class MiddleSchoolBatch < ApplicationRecord
  include BatchConcern

  # Association
  has_many :importing_middle_schools, inverse_of: :middle_school_batch, dependent: :destroy
  has_many :middle_schools, through: :importing_middle_schools

  # Nested attributes
  accepts_nested_attributes_for :importing_middle_schools
end

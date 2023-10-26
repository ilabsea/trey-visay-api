# frozen_string_literal: true

# == Schema Information
#
# Table name: major_personality_types
#
#  id                  :bigint(8)        not null, primary key
#  major_id            :string(255)
#  personality_type_id :string(255)
#  display_order       :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class MajorPersonalityType < ApplicationRecord
  # Association
  belongs_to :major
  belongs_to :personality_type

  # Validation
  validates :display_order, presence: true

  # Scope
  default_scope { order(display_order: :asc) }
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: personality_tests
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PersonalityTest < ApplicationRecord
  belongs_to :user
  has_many :personality_selections, dependent: :destroy
  has_many :personalities, through: :personality_selections

  accepts_nested_attributes_for :personality_selections
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: personality_selections
#
#  id                  :bigint(8)        not null, primary key
#  personality_code    :string(255)
#  personality_test_id :integer
#

class PersonalitySelection < ApplicationRecord
  belongs_to :personality, foreign_key: :personality_code
  belongs_to :personality_test
end

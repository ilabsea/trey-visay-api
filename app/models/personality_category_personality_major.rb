# frozen_string_literal: true

# == Schema Information
#
# Table name: personality_category_personality_majors
#
#  id                        :bigint(8)        not null, primary key
#  personality_category_code :string(255)
#  personality_major_code    :string(255)
#

class PersonalityCategoryPersonalityMajor < ApplicationRecord
  belongs_to :personality_category, foreign_key: :personality_category_code
  belongs_to :personality_major, foreign_key: :personality_major_code
end

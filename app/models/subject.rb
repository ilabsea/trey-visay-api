# frozen_string_literal: true

# == Schema Information
#
# Table name: subjects
#
#  id                                  :integer          not null, primary key
#  game_id                             :integer          not null
#  khmer_reading                       :string(255)
#  khmer_writing                       :string(255)
#  english                             :string(255)
#  math                                :string(255)
#  social_study_ethics_and_citizenship :string(255)
#  social_study_geography              :string(255)
#  social_study_history                :string(255)
#  science_physics                     :string(255)
#  science_chemistry                   :string(255)
#  science_biology                     :string(255)
#  soft_skill_communication            :string(255)
#  soft_skill_brave                    :string(255)
#  soft_skill_teamwork                 :string(255)
#  soft_skill_problemsolving           :string(255)
#  soft_skill_publicspeaking           :string(255)
#

class Subject < ApplicationRecord
  ANSWERS = %w[ខ្លាំង មធ្យម ខ្សោយ].freeze

  belongs_to :game
end

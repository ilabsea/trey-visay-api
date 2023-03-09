# frozen_string_literal: true

# == Schema Information
#
# Table name: personal_understandings
#
#  id                                               :bigint(8)        not null, primary key
#  user_id                                          :integer
#  game_id                                          :integer
#  are_you_going_to_study_till_grade12              :string(255)
#  are_your_parents_allow_you_to_study_till_grade12 :string(255)
#  have_you_ever_thought_of_career                  :string(255)
#  career_name                                      :string(255)
#  how_to_reach_career_goal                         :string(255)
#  does_parents_agree_with                          :string(255)
#  ever_talked_with_anyone_about_career             :string(255)
#  how_to_reach_job_vacancy                         :string(255)
#  who_to_reach_job_vacancy                         :string(255)
#  score                                            :integer
#  created_at                                       :datetime         not null
#  updated_at                                       :datetime         not null
#

class PersonalUnderstanding < ApplicationRecord
  YES_NO_ANSWERS = %w[Yes No Don_Know].freeze

  belongs_to :game
  scope :fails, -> { where('score < ?', 12) }

  def fail?
    score < 12
  end
end

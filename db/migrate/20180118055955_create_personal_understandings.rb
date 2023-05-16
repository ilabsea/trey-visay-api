# frozen_string_literal: true

class CreatePersonalUnderstandings < ActiveRecord::Migration[5.1]
  def change
    create_table :personal_understandings do |t|
      t.integer :user_id
      t.integer :game_id
      t.string  :are_you_going_to_study_till_grade12, null: true
      t.string  :are_your_parents_allow_you_to_study_till_grade12, null: true
      t.string  :have_you_ever_thought_of_career, null: true
      t.string  :career_name, null: true
      t.string  :how_to_reach_career_goal, null: true
      t.string  :does_parents_agree_with, null: true
      t.string  :ever_talked_with_anyone_about_career, null: true
      t.string  :how_to_reach_job_vacancy, null: true
      t.string  :who_to_reach_job_vacancy, null: true
      t.string  :score, null: true

      t.timestamps null: false
    end
  end
end

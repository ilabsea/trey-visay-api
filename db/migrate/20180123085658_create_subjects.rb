# frozen_string_literal: true

class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.integer :game_id, null: false
      t.string  :khmer_reading
      t.string  :khmer_writing
      t.string  :english
      t.string  :math
      t.string  :social_study_ethics_and_citizenship
      t.string  :social_study_geography
      t.string  :social_study_history
      t.string  :science_physics
      t.string  :science_chemistry
      t.string  :science_biology
      t.string  :soft_skill_communication
      t.string  :soft_skill_brave
      t.string  :soft_skill_teamwork
      t.string  :soft_skill_problemsolving
      t.string  :soft_skill_publicspeaking
    end
  end
end

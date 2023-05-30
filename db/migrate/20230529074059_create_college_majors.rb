# frozen_string_literal: true

class CreateCollegeMajors < ActiveRecord::Migration[5.2]
  def change
    create_table :college_majors, id: :string do |t|
      t.string :code
      t.string :name
      t.string :personality_type
      t.text :general_info
      t.text :orien_orientation_subjects
      t.text :orien_study_condition
      t.text :orien_graduation_condition
      t.text :curriculum
      t.text :teaching_and_learning_process
      t.text :gain_knowledge
      t.text :worthy_career
      t.text :recommendation

      t.timestamps
    end
  end
end

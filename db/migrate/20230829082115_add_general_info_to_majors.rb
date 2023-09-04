# frozen_string_literal: true

class AddGeneralInfoToMajors < ActiveRecord::Migration[5.2]
  def change
    add_column :majors, :code,                          :string
    add_column :majors, :parent_code,                   :string
    add_column :majors, :personality_type,              :string
    add_column :majors, :general_info,                  :text
    add_column :majors, :orien_orientation_subjects,    :text
    add_column :majors, :orien_study_condition,         :text
    add_column :majors, :orien_graduation_condition,    :text
    add_column :majors, :curriculum,                    :text
    add_column :majors, :teaching_and_learning_process, :text
    add_column :majors, :gain_knowledge,                :text
    add_column :majors, :worthy_career,                 :text
    add_column :majors, :recommendation,                :text
  end
end

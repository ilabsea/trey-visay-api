# frozen_string_literal: true

class RenameColumnsInSubjects < ActiveRecord::Migration[5.1]
  def change
    rename_column :subjects, :soft_skill_problemsolving, :soft_skill_problem_solving
    rename_column :subjects, :soft_skill_publicspeaking, :soft_skill_public_speaking
  end
end

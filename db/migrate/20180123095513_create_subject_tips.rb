# frozen_string_literal: true

class CreateSubjectTips < ActiveRecord::Migration[5.1]
  def change
    create_table :subject_tips do |t|
      t.string :subject_code, null: false
      t.string :tip, null: false
      t.string :tip_type, null: false
    end
  end
end

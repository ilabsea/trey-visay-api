# frozen_string_literal: true

class CreateImportingCollegeMajors < ActiveRecord::Migration[5.2]
  def change
    create_table :importing_college_majors do |t|
      t.string :college_major_id
      t.string :college_major_batch_id

      t.timestamps
    end
  end
end

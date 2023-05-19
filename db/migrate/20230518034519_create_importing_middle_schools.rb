# frozen_string_literal: true

class CreateImportingMiddleSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :importing_middle_schools do |t|
      t.string :middle_school_id
      t.string :middle_school_batch_id

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateImportingSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :importing_schools do |t|
      t.integer :school_id
      t.string  :school_batch_id

      t.timestamps
    end
  end
end

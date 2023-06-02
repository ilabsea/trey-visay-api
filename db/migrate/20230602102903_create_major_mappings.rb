# frozen_string_literal: true

class CreateMajorMappings < ActiveRecord::Migration[5.2]
  def change
    create_table :major_mappings do |t|
      t.integer :major_id
      t.string  :college_major_id

      t.timestamps
    end
  end
end

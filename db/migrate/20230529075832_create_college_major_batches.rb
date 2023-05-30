# frozen_string_literal: true

class CreateCollegeMajorBatches < ActiveRecord::Migration[5.2]
  def change
    create_table :college_major_batches, id: :string do |t|
      t.string  :code
      t.integer :total_count, default: 0
      t.integer :valid_count, default: 0
      t.integer :new_count, default: 0
      t.string  :reference
      t.integer :creator_id

      t.timestamps
    end
  end
end

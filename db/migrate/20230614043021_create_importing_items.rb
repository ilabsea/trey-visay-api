# frozen_string_literal: true

class CreateImportingItems < ActiveRecord::Migration[5.2]
  def change
    create_table :importing_items do |t|
      t.string :itemable_id
      t.string :itemable_type
      t.string :batch_id

      t.timestamps
    end
  end
end

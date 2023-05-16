# frozen_string_literal: true

class CreateCharacteristicsEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :characteristics_entries, id: false do |t|
      t.belongs_to :characteristic, index: true
      t.belongs_to :entry, index: true
    end
  end
end

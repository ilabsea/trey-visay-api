# frozen_string_literal: true

class AddConcernedToCharacteristicsEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :characteristics_entries, :id, :primary_key
    add_column :characteristics_entries, :concerned, :boolean, default: false
  end
end

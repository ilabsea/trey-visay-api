# frozen_string_literal: true

class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :name, null: false
    end
  end
end

# frozen_string_literal: true

class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.text :user
      t.text :game

      t.timestamps
    end
  end
end

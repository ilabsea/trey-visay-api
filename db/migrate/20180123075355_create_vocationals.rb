# frozen_string_literal: true

class CreateVocationals < ActiveRecord::Migration[5.1]
  def change
    create_table :vocationals do |t|
      t.string :title, null: false
      t.text   :description, null: false

      t.timestamps null: false
    end
  end
end

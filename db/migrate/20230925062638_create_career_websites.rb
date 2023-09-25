# frozen_string_literal: true

class CreateCareerWebsites < ActiveRecord::Migration[5.2]
  def change
    create_table :career_websites, id: :string do |t|
      t.string :name
      t.string :description
      t.string :url
      t.string :logo

      t.timestamps
    end
  end
end

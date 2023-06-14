# frozen_string_literal: true

class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos, id: :string do |t|
      t.string :code
      t.string :name
      t.string :url
      t.string :author

      t.timestamps
    end
  end
end

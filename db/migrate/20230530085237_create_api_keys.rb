# frozen_string_literal: true

class CreateApiKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :api_keys do |t|
      t.string :access_token

      t.timestamps
    end
  end
end

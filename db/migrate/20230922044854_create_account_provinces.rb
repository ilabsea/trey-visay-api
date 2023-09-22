# frozen_string_literal: true

class CreateAccountProvinces < ActiveRecord::Migration[5.2]
  def change
    create_table :account_provinces do |t|
      t.integer :account_id
      t.string  :province_id

      t.timestamps
    end
  end
end

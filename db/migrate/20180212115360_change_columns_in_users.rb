# frozen_string_literal: true

class ChangeColumnsInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :sex, :string, null: true
    change_column :users, :date_of_birth, :date, null: true
    change_column :users, :nationality, :string, null: true
    change_column :users, :grade, :string, null: true
    change_column :users, :address, :string, null: true
  end
end

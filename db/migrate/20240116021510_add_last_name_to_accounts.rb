# frozen_string_literal: true

class AddLastNameToAccounts < ActiveRecord::Migration[6.0]
  def change
    rename_column :accounts, :full_name, :first_name
    add_column :accounts, :last_name, :string
  end
end

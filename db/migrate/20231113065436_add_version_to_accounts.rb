# frozen_string_literal: true

class AddVersionToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :version, :integer, default: 1
  end
end

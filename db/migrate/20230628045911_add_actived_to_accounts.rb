# frozen_string_literal: true

class AddActivedToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :actived, :boolean, default: true
    add_column :accounts, :gf_user_id, :integer
  end
end

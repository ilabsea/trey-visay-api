# frozen_string_literal: true

class AddAppInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :device_id, :string
    add_column :users, :device_type, :integer
    add_column :users, :device_os, :integer
    add_column :users, :app_version, :integer
  end
end

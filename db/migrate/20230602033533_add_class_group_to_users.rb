# frozen_string_literal: true

class AddClassGroupToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :class_group, :integer
    add_column :users, :middle_school_id, :integer

    rename_column :users, :province_code, :province_id
    rename_column :users, :district_code, :district_id
  end

  def down
    remove_column :users, :class_group
    remove_column :users, :middle_school_id

    rename_column :users, :province_id, :province_code
    rename_column :users, :district_id, :district_code
  end
end

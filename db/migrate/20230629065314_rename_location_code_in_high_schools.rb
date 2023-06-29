# frozen_string_literal: true

class RenameLocationCodeInHighSchools < ActiveRecord::Migration[5.2]
  def up
    rename_column :high_schools, :location_code, :district_id
    change_column :high_schools, :code, :string, limit: 10
    add_column :high_schools, :province_id, :string
    add_column :high_schools, :commune_id, :string
  end

  def down
    rename_column :high_schools, :district_id, :location_code
    remove_column :high_schools, :province_id
    remove_column :high_schools, :commune_id
  end
end

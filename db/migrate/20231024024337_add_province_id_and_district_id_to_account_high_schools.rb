# frozen_string_literal: true

class AddProvinceIdAndDistrictIdToAccountHighSchools < ActiveRecord::Migration[6.0]
  def change
    add_column :account_high_schools, :province_id, :string
    add_column :account_high_schools, :district_id, :string
  end
end

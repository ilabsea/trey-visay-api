# frozen_string_literal: true

class AddProvinceIdAndDistrictIdToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :province_id, :string
    add_column :accounts, :district_id, :string
  end
end

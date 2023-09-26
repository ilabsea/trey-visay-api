# frozen_string_literal: true

class AddProvinceIdToSchools < ActiveRecord::Migration[5.2]
  def change
    add_column :schools, :province_id, :string
  end
end

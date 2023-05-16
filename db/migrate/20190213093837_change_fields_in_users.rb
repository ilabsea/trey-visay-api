# frozen_string_literal: true

class ChangeFieldsInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :school_name, :string, null: true
    remove_column(:users, :address)
    remove_column(:users, :nationality)
    remove_column(:users, :father_name)
    remove_column(:users, :father_occupation)
    remove_column(:users, :mother_name)
    remove_column(:users, :mother_occupation)
    remove_column(:users, :guidance)
    remove_column(:users, :parent_contact_number)
    remove_column(:users, :number_of_family_member)
    remove_column(:users, :number_of_sisters)
    remove_column(:users, :number_of_brothers)
    remove_column(:users, :is_divorce)
    remove_column(:users, :is_disable)
    remove_column(:users, :is_domestic_violence)
    remove_column(:users, :is_smoking)
    remove_column(:users, :is_alcoholic)
    remove_column(:users, :is_drug)
    remove_column(:users, :house_type)
    remove_column(:users, :collective_income)
    add_column(:users, :province_code, :string, null: true)
    add_column(:users, :district_code, :string, null: true)
    add_column(:users, :commune_code, :string, null: true)
  end
end

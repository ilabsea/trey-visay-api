# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string   :uuid
      t.string   :full_name,            null: false
      t.string   :password,             null: false
      t.string   :username,             null: false
      t.string   :sex,                  null: false

      t.date     :date_of_birth,          null: false
      t.string   :phone_number,          null: true
      t.string   :nationality,          null: false
      t.string   :school_name,           null: false
      t.string   :grade,                null: false
      t.string   :address,              null: false

      t.string   :father_name,           null: true
      t.string   :father_occupation,     null: true
      t.string   :mother_name,           null: true
      t.string   :mother_occupation,     null: true
      t.string   :guidance,             null: true
      t.string   :parent_contact_number,  null: true
      t.integer  :number_of_family_member, null: true
      t.integer  :number_of_sisters,      null: true
      t.integer  :number_of_brothers,     null: true

      t.boolean  :is_divorce,            null: true
      t.boolean  :is_disable,            null: true
      t.boolean  :is_domestic_violence,   null: true
      t.boolean  :is_smoking,            null: true
      t.boolean  :is_alcoholic,          null: true
      t.boolean  :is_drug,               null: true
      t.string   :house_type,            null: true
      t.string   :collective_income,     null: true

      t.timestamps null: false
    end
  end
end

# frozen_string_literal: true

class AddFullNameAndPhoneNumberToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :full_name, :string
    add_column :accounts, :phone_number, :string
  end
end

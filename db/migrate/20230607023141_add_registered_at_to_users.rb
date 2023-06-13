# frozen_string_literal: true

class AddRegisteredAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :registered_at, :datetime
  end
end

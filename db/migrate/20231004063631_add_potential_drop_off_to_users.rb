# frozen_string_literal: true

class AddPotentialDropOffToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :potential_drop_off, :boolean
  end
end

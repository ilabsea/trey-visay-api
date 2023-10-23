# frozen_string_literal: true

class AddDisplayOrderToSchools < ActiveRecord::Migration[6.0]
  def change
    add_column :schools, :display_order, :integer
  end
end

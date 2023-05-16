# frozen_string_literal: true

class AddCodeToSchool < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :code, :string
  end
end

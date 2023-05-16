# frozen_string_literal: true

class AddKindToSchools < ActiveRecord::Migration[5.2]
  def change
    add_column :schools, :kind, :integer
  end
end

# frozen_string_literal: true

class AddColumnGradeToDepartments < ActiveRecord::Migration[5.2]
  def change
    add_column :departments, :grade, :integer
    add_column :majors, :grade, :integer
  end
end

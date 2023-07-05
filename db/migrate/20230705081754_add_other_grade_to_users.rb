# frozen_string_literal: true

class AddOtherGradeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :other_grade, :integer
  end
end

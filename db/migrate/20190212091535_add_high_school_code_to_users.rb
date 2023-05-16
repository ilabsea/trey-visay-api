# frozen_string_literal: true

class AddHighSchoolCodeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :high_school_code, :string
  end
end

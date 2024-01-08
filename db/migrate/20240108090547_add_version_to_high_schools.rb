# frozen_string_literal: true

class AddVersionToHighSchools < ActiveRecord::Migration[6.0]
  def change
    add_column :high_schools, :version, :integer, default: 1
  end
end

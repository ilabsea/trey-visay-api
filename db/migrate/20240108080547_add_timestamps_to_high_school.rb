# frozen_string_literal: true

class AddTimestampsToHighSchool < ActiveRecord::Migration[6.0]
  def change
    add_column :high_schools, :created_at, :datetime
    add_column :high_schools, :updated_at, :datetime
  end
end

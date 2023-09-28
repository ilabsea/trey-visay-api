# frozen_string_literal: true

class AddDeletedAtToHighSchools < ActiveRecord::Migration[5.2]
  def change
    add_column :high_schools, :deleted_at, :datetime
  end
end

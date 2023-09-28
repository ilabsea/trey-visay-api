# frozen_string_literal: true

class AddDeletedAtToMajors < ActiveRecord::Migration[5.2]
  def change
    add_column :majors, :deleted_at, :datetime
  end
end

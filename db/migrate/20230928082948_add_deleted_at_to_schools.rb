# frozen_string_literal: true

class AddDeletedAtToSchools < ActiveRecord::Migration[5.2]
  def change
    add_column :schools, :deleted_at, :datetime
  end
end

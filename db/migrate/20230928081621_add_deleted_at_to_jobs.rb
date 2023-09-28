# frozen_string_literal: true

class AddDeletedAtToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :deleted_at, :datetime
  end
end

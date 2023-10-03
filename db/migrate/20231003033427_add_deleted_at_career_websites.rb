# frozen_string_literal: true

class AddDeletedAtCareerWebsites < ActiveRecord::Migration[5.2]
  def change
    add_column :career_websites, :deleted_at, :datetime
  end
end

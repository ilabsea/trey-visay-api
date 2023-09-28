# frozen_string_literal: true

class AddDeletedAtToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :deleted_at, :datetime
  end
end

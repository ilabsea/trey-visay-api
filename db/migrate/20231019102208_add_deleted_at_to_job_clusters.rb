# frozen_string_literal: true

class AddDeletedAtToJobClusters < ActiveRecord::Migration[6.0]
  def change
    add_column :job_clusters, :deleted_at, :datetime
  end
end

# frozen_string_literal: true

class AddLogoToJobClusters < ActiveRecord::Migration[6.0]
  def change
    add_column :job_clusters, :logo, :string
  end
end

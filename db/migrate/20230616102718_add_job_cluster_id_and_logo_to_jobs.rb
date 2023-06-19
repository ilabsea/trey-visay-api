# frozen_string_literal: true

class AddJobClusterIdAndLogoToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :job_cluster_id, :string
    add_column :jobs, :logo, :string
  end
end

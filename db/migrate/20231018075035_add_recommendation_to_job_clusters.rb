# frozen_string_literal: true

class AddRecommendationToJobClusters < ActiveRecord::Migration[6.0]
  def change
    add_column :job_clusters, :recommendation, :text
  end
end

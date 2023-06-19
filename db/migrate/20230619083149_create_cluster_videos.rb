# frozen_string_literal: true

class CreateClusterVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :cluster_videos do |t|
      t.string :video_id
      t.string :job_cluster_id

      t.timestamps
    end
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: cluster_videos
#
#  id             :bigint(8)        not null, primary key
#  video_id       :string(255)
#  job_cluster_id :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class ClusterVideo < ApplicationRecord
  belongs_to :job_cluster
  belongs_to :video
end

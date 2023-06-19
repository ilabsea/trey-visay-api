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
require "rails_helper"

RSpec.describe ClusterVideo, type: :model do
  it { is_expected.to belong_to(:job_cluster) }
  it { is_expected.to belong_to(:video) }
end

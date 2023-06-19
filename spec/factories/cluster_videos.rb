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
FactoryBot.define do
  factory :cluster_video do
  end
end

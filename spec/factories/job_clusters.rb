# frozen_string_literal: true

# == Schema Information
#
# Table name: job_clusters
#
#  id            :string(255)      not null, primary key
#  code          :string(255)
#  name          :string(255)
#  display_order :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :job_cluster do
  end
end
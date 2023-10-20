# frozen_string_literal: true

# == Schema Information
#
# Table name: job_clusters
#
#  id             :string(255)      not null, primary key
#  code           :string(255)
#  name           :string(255)
#  display_order  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  recommendation :text(65535)
#  deleted_at     :datetime
#  logo           :string(255)
#
FactoryBot.define do
  factory :job_cluster do
    name { FFaker::Name.name }
  end
end

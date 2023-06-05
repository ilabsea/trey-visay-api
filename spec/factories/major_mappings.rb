# frozen_string_literal: true

# == Schema Information
#
# Table name: major_mappings
#
#  id               :bigint(8)        not null, primary key
#  major_id         :integer
#  college_major_id :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :major_mapping do
  end
end
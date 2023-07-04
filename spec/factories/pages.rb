# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id             :string(255)      not null, primary key
#  code           :string(255)
#  name_km        :string(255)
#  name_en        :string(255)
#  parent_id      :string(255)
#  visits_count   :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_pages_on_lft  (lft)
#  index_pages_on_rgt  (rgt)
#
FactoryBot.define do
  factory :page do
    name_km  { FFaker::Name.name }
    code     { "abc" }

    trait :with_parent do
      parent_id { create(:page).id }
    end
  end
end

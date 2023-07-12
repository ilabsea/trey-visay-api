# frozen_string_literal: true

# == Schema Information
#
# Table name: locations
#
#  id         :string(255)      not null, primary key
#  name_en    :string(255)      not null
#  name_km    :string(255)      not null
#  kind       :string(255)      not null
#  parent_id  :string(255)
#  latitude   :float(24)
#  longitude  :float(24)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :location do
    id { "01" }
    name_en { "Banteay Meanchey" }
    name_km { "បន្ទាយមានជ័យ" }
    kind { "province" }
    parent_id { nil }
    latitude { 13.7531914 }
    longitude { 102.989615 }
  end
end

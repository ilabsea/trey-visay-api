# frozen_string_literal: true

# == Schema Information
#
# Table name: visits
#
#  id            :string(255)      not null, primary key
#  page_id       :string(255)
#  user_id       :integer
#  visit_date    :datetime
#  pageable_id   :string(255)
#  pageable_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  device_os     :integer
#
FactoryBot.define do
  factory :visit do
    visit_date { DateTime.yesterday }
    page
    user
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: importing_items
#
#  id            :bigint(8)        not null, primary key
#  itemable_id   :string(255)
#  itemable_type :string(255)
#  batch_id      :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :importing_item do
  end
end

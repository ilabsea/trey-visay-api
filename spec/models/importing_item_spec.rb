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
require "rails_helper"

RSpec.describe ImportingItem, type: :model do
  it { is_expected.to belong_to(:itemable) }
  it { is_expected.to belong_to(:batch) }
end

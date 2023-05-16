# frozen_string_literal: true

# == Schema Information
#
# Table name: personalities
#
#  code       :string(36)       not null, primary key
#  name_km    :string(255)
#  name_en    :string(255)
#  category   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_personalities_on_code  (code) UNIQUE
#
require "rails_helper"

RSpec.describe Personality, type: :model do
  it { is_expected.to have_many(:personality_selections) }
  it { is_expected.to validate_presence_of(:name_km) }
  it { is_expected.to validate_inclusion_of(:category).in_array(%w(realistic investigative artistic social enterprising conventional)) }
end

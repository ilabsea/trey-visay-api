# frozen_string_literal: true

# == Schema Information
#
# Table name: major_personality_types
#
#  id                  :bigint(8)        not null, primary key
#  major_id            :string(255)
#  personality_type_id :string(255)
#  display_order       :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require "rails_helper"

RSpec.describe MajorPersonalityType, type: :model do
  it { is_expected.to belong_to(:major) }
  it { is_expected.to belong_to(:personality_type) }

  it { is_expected.to validate_presence_of(:display_order) }
end

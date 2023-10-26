# frozen_string_literal: true

# == Schema Information
#
# Table name: personality_types
#
#  id                :string(255)      not null, primary key
#  code              :string(255)
#  name_km           :string(255)
#  name_en           :string(255)
#  recommendation    :text(65535)
#  description       :text(65535)
#  personal_value    :text(65535)
#  skill_and_ability :text(65535)
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require "rails_helper"

RSpec.describe PersonalityType, type: :model do
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:name_km) }
  it { is_expected.to validate_presence_of(:name_en) }
  it { is_expected.to validate_presence_of(:recommendation) }
end

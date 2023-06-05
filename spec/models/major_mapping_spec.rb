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
require "rails_helper"

RSpec.describe MajorMapping, type: :model do
  it { is_expected.to belong_to(:major) }
  it { is_expected.to belong_to(:college_major) }
end

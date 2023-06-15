# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id         :string(255)      not null, primary key
#  code       :string(255)
#  name       :string(255)
#  url        :string(255)
#  author     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Video, type: :model do
  it { is_expected.to have_many(:importing_items) }
  it { is_expected.to have_many(:batches).through(:importing_items) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:author) }
end

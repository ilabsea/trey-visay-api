# frozen_string_literal: true

# == Schema Information
#
# Table name: career_websites
#
#  id          :string(255)      not null, primary key
#  name        :string(255)
#  description :string(255)
#  url         :string(255)
#  logo        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted_at  :datetime
#
require "rails_helper"

RSpec.describe CareerWebsite, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:url) }
end

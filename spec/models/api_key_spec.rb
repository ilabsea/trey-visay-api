# frozen_string_literal: true

# == Schema Information
#
# Table name: api_keys
#
#  id           :bigint(8)        not null, primary key
#  access_token :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require "rails_helper"

RSpec.describe ApiKey, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

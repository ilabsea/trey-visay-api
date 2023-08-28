# frozen_string_literal: true

# == Schema Information
#
# Table name: holland_major_responses
#
#  id              :string(255)      not null, primary key
#  holland_quiz_id :string(255)
#  selected        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  major_id        :integer
#
require "rails_helper"

RSpec.describe HollandMajorResponse, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

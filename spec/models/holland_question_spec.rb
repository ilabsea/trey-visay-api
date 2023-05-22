# frozen_string_literal: true

# == Schema Information
#
# Table name: holland_questions
#
#  id               :string(255)      not null, primary key
#  code             :string(255)
#  name             :string(255)
#  personality_type :string(255)
#  display_order    :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "rails_helper"

RSpec.describe HollandQuestion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

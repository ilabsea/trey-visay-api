# == Schema Information
#
# Table name: personality_selections
#
#  id                  :bigint(8)        not null, primary key
#  personality_code    :string(255)
#  personality_test_id :integer
#
require "rails_helper"

RSpec.describe PersonalitySelection, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

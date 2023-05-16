# frozen_string_literal: true

# == Schema Information
#
# Table name: personality_tests
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :personality_test do
  end
end

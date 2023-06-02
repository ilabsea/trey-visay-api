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
FactoryBot.define do
  factory :holland_question do
    code { "R_01" }
    name { "ចិញ្ចឹមថែទាំសត្វ" }
    personality_type { "R" }
  end
end

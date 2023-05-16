# == Schema Information
#
# Table name: personality_selections
#
#  id                  :bigint(8)        not null, primary key
#  personality_code    :string(255)
#  personality_test_id :integer
#
FactoryBot.define do
  factory :personality_selection do
  end
end

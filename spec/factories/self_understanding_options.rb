# frozen_string_literal: true

# == Schema Information
#
# Table name: self_understanding_options
#
#  id                             :string(255)      not null, primary key
#  code                           :string(255)
#  name                           :string(255)
#  value                          :string(255)
#  self_understanding_question_id :string(255)
#  display_order                  :integer          default(1)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
FactoryBot.define do
  factory :self_understanding_option do
  end
end

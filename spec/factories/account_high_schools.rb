# frozen_string_literal: true

# == Schema Information
#
# Table name: account_high_schools
#
#  id             :bigint(8)        not null, primary key
#  high_school_id :string(255)
#  account_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :account_high_school do
  end
end

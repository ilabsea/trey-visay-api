# == Schema Information
#
# Table name: personality_tests
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe PersonalityTest, type: :model do
  it { is_expected.to have_many(:personality_selections) }
  it { is_expected.to belong_to(:user) }
end

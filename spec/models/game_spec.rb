# == Schema Information
#
# Table name: games
#
#  id                :bigint(8)        not null, primary key
#  user_id           :integer          not null
#  characteristic_id :integer
#  reason            :string(255)
#  audio             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_date      :datetime
#  goal              :string(255)
#

require 'rails_helper'

RSpec.describe Game, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:characteristic) }
  it { is_expected.to have_many(:personal_understandings) }
  it { is_expected.to have_many(:career_games) }
  it { is_expected.to have_many(:careers).through(:career_games) }
  it { is_expected.to have_and_belong_to_many(:entries) }
  it { is_expected.to have_one(:subject) }
end

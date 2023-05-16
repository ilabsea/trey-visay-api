# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id               :bigint(8)        not null, primary key
#  uuid             :string(255)
#  full_name        :string(255)      not null
#  password         :string(255)      not null
#  username         :string(255)      not null
#  sex              :string(255)
#  date_of_birth    :date
#  phone_number     :string(255)
#  school_name      :string(255)
#  grade            :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  photo            :string(255)
#  high_school_code :string(255)
#  province_code    :string(255)
#  district_code    :string(255)
#  commune_code     :string(255)
#

require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to belong_to(:high_school) }
  it { is_expected.to have_many(:games) }
  it { is_expected.to have_many(:personality_tests) }
  it { is_expected.to have_many(:personal_understandings).through(:games) }
  it { is_expected.to validate_inclusion_of(:grade).in_array(%w(9 10 11 12 other)) }
end

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

FactoryBot.define do
  factory :user do
    username      { FFaker::Name.name }
    full_name     { FFaker::Name.name }
    uuid          { FFaker::Name.name }
    password      { FFaker::Name.name }
  end
end

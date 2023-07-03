# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default(FALSE)
#  is_counsellor          :boolean          default(FALSE)
#  schools                :text(65535)
#  authentication_token   :string(255)
#  token_expired_date     :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  role                   :integer
#  deleted_at             :datetime
#  locale                 :string(255)
#  counselor_school_id    :string(255)
#  actived                :boolean          default(TRUE)
#  gf_user_id             :integer
#  province_id            :string(255)
#  district_id            :string(255)
#  full_name              :string(255)
#  phone_number           :string(255)
#
# Indexes
#
#  index_accounts_on_email                 (email) UNIQUE
#  index_accounts_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :account, aliases: [:creator] do
    email         { FFaker::Internet.email }
    password      { FFaker::Internet.password }
    role          { "admin" }
    confirmed_at  { DateTime.now }
    skip_callback { true }

    trait :allow_callback do
      skip_callback { false }
    end

    trait :system_admin do
      role { "system_admin" }
    end

    trait :admin do
      role { "admin" }
    end

    trait :counselor do
      role { "counselor" }
      high_school_ids { [create(:high_school).id] }
    end
  end
end

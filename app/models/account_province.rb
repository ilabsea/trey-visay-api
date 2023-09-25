# frozen_string_literal: true

# == Schema Information
#
# Table name: account_provinces
#
#  id          :bigint(8)        not null, primary key
#  account_id  :integer
#  province_id :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class AccountProvince < ApplicationRecord
  belongs_to :account
  belongs_to :province, foreign_key: :province_id, class_name: "Location"
end

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
#  province_id    :string(255)
#  district_id    :string(255)
#
class AccountHighSchool < ApplicationRecord
  belongs_to :high_school, optional: true
  belongs_to :province, foreign_key: :province_id, class_name: "Location", optional: true
  belongs_to :account

  before_validation :assign_location

  private
    def assign_location
      if high_school.present?
        self.province_id = high_school.province_id
        self.district_id = high_school.district_id
      else
        self.district_id = "all"
        self.high_school_id = "all"
      end
    end
end

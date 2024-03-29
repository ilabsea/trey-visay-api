# frozen_string_literal: true

# == Schema Information
#
# Table name: counselor_schools
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CounselorSchool < ApplicationRecord
  validates :name, presence: true
end

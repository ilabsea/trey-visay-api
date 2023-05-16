# frozen_string_literal: true

# == Schema Information
#
# Table name: subject_tips
#
#  id           :bigint(8)        not null, primary key
#  subject_code :string(255)      not null
#  tip          :string(255)      not null
#  tip_type     :string(255)      not null
#

class SubjectTip < ApplicationRecord
  scope :subject_by, ->(code) { where(subject_code: code) }
  scope :mediums, -> { where(tip_type: "medium") }
  scope :poors, -> { where(tip_type: "poor") }

  validates :subject_code, presence: true
  validates :tip, presence: true
  validates :tip_type, presence: true
end

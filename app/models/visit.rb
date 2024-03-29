# frozen_string_literal: true

# == Schema Information
#
# Table name: visits
#
#  id            :string(255)      not null, primary key
#  page_id       :string(255)
#  user_id       :integer
#  visit_date    :datetime
#  pageable_id   :string(255)
#  pageable_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  device_os     :integer
#
class Visit < ApplicationRecord
  # Enum
  enum device_os: {
    android: 1,
    ios: 2,
    other: 3
  }

  # Association
  belongs_to :page, counter_cache: true
  belongs_to :user, optional: true
  belongs_to :pageable, -> { with_deleted }, polymorphic: true, optional: true

  # Callback
  before_create :secure_id
  before_validation :set_pageable

  # Delegation
  delegate :name, :code, to: :page, prefix: true, allow_nil: true
  delegate :name, to: :pageable, prefix: true, allow_nil: true
  delegate :display_device_id, to: :user, prefix: false, allow_nil: true

  # Nested attribute
  accepts_nested_attributes_for :page, reject_if: lambda { |attributes|
    attributes["code"].blank?
  }

  # Instant method
  def page_attributes=(attribute)
    _page = Page.find_or_initialize_by(code: attribute[:code])
    _page.parent ||= Page.find_or_create_by(code: attribute[:parent_code]) if attribute[:parent_code].present?
    _page.update(name_km: attribute[:name])

    self.page = _page
    set_pageable
  end

  def set_pageable
    self.pageable ||= page
  end

  def last_visit
    self.class.where(user_id: user_id, pageable_type: pageable_type, pageable_id: pageable_id)
              .where("visit_date >= ?", visit_date - 30.minutes)
              .first
  end

  def page_detail
    return if pageable_type == "Page"

    pageable_name
  end

  # Class method
  def self.filter(params = {})
    scope = all
    scope = scope.where("visit_date BETWEEN ? AND ?", params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
    scope = scope.where(page_id: params[:page_ids]) if params[:page_ids].present?
    scope = scope.joins(:user).where('users.device_os': params[:platform]) if params[:platform].present?
    scope
  end
end

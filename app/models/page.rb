# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id             :string(255)      not null, primary key
#  code           :string(255)
#  name_km        :string(255)
#  name_en        :string(255)
#  parent_id      :string(255)
#  visits_count   :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  deleted_at     :datetime
#
# Indexes
#
#  index_pages_on_lft  (lft)
#  index_pages_on_rgt  (rgt)
#
class Page < ApplicationRecord
  acts_as_paranoid
  acts_as_nested_set

  has_many :visits

  before_create :secure_id
  before_create :secure_code
  before_validation :set_name_en

  def name
    self["name_#{I18n.locale}"]
  end

  def self.filter(params)
    keyword = params[:name].to_s.downcase.strip
    scope = all
    scope = scope.where("LOWER(code) LIKE ? OR name_km LIKE ? OR name_en LIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%") if keyword.present?
    scope
  end

  private
    def set_name_en
      self.name_en ||= name_km
    end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: high_schools
#
#  code        :string(10)       not null, primary key
#  name_km     :string(255)
#  name_en     :string(255)
#  district_id :string(255)
#  province_id :string(255)
#  commune_id  :string(255)
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  version     :integer          default(1)
#
# Indexes
#
#  index_high_schools_on_code  (code) UNIQUE
#
class HighSchoolSerializer < ActiveModel::Serializer
  attributes :id, :code, :label, :province_id, :district_id, :parent_code,
             :name_km, :name_en, :updated_at, :deleted_at

  def parent_code
    object.district_id
  end

  def label
    object.name_km
  end
end

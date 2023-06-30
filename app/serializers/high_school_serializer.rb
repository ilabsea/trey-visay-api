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
#
# Indexes
#
#  index_high_schools_on_code  (code) UNIQUE
#
class HighSchoolSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :name_km, :name_en, :province_id, :district_id, :commune_id,
             :province, :district, :commune, :parent_code, :label

  def parent_code
    object.district_id
  end

  def label
    object.name_km
  end
end

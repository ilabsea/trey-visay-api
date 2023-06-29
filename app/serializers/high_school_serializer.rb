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
  attributes :id, :code, :name, :province_id, :district_id, :commune_id,
             :province, :district, :commune

  def province
    object.province
  end

  def district
    object.district
  end

  def commune
    object.commune
  end
end

# == Schema Information
#
# Table name: middle_schools
#
#  id          :string(8)        not null, primary key
#  code        :string(255)
#  name        :string(255)
#  province_id :string(255)
#  district_id :string(255)
#  commune_id  :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class MiddleSchoolSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :province_id, :district_id, :commune_id, :updated_at,
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

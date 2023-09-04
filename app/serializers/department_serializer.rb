# frozen_string_literal: true

# == Schema Information
#
# Table name: departments
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  grade      :integer
#

class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :school_id

  has_many :majors
end

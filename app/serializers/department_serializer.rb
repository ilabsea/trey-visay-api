# frozen_string_literal: true

# == Schema Information
#
# Table name: departments
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  school_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :school_id

  has_many :majors
end

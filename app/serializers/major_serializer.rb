# frozen_string_literal: true

# == Schema Information
#
# Table name: majors
#
#  id            :bigint(8)        not null, primary key
#  name          :string(255)      not null
#  department_id :integer
#  school_id     :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class MajorSerializer < ActiveModel::Serializer
  attributes :id, :name, :department_id
end

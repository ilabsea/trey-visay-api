# frozen_string_literal: true

# == Schema Information
#
# Table name: schools
#
#  id                  :bigint(8)        not null, primary key
#  name                :string(255)      not null
#  logo                :string(255)
#  address             :string(255)
#  province            :string(255)
#  phone_numbers       :string(255)
#  faxes               :string(255)
#  emails              :string(255)
#  website_or_facebook :string(255)
#  mailbox             :string(255)
#  category            :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  code                :string(255)
#  kind                :integer
#  province_id         :string(255)
#  deleted_at          :datetime
#

class SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :logo, :address, :province, :phone_numbers, :faxes,
             :emails, :website_or_facebook, :mailbox, :category, :departments,
             :kind, :province_id

  def departments
    object.school_departments.map do |sd|
      {
        name: sd.department_name,
        majors: sd.school_majors.map { |sm| { name: sm.major.name, id: sm.major.id } }
      }
    end
  end
end

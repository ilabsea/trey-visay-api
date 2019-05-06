# frozen_string_literal: true

# == Schema Information
#
# Table name: schools
#
#  id                  :integer          not null, primary key
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
#

class SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :logo, :address, :province, :phone_numbers, :faxes, :emails, :website_or_facebook, :mailbox, :category

  has_many :departments
end

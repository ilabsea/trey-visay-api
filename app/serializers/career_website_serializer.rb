# frozen_string_literal: true

# == Schema Information
#
# Table name: career_websites
#
#  id          :string(255)      not null, primary key
#  name        :string(255)
#  description :string(255)
#  url         :string(255)
#  logo        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class CareerWebsiteSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :url, :logo_url, :updated_at
end

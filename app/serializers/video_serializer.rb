# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id         :string(255)      not null, primary key
#  code       :string(255)
#  name       :string(255)
#  url        :string(255)
#  author     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#
class VideoSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :url, :author, :updated_at
end

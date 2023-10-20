# frozen_string_literal: true

# == Schema Information
#
# Table name: job_clusters
#
#  id             :string(255)      not null, primary key
#  code           :string(255)
#  name           :string(255)
#  display_order  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  recommendation :text(65535)
#  deleted_at     :datetime
#  logo           :string(255)
#
class JobClusterSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :logo, :recommendation,
             :updated_at, :deleted_at

  has_many :videos
end

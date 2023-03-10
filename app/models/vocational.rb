# frozen_string_literal: true

# == Schema Information
#
# Table name: vocationals
#
#  id          :bigint(8)        not null, primary key
#  title       :string(255)      not null
#  description :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Vocational < ApplicationRecord
  has_many :careers, as: :categorizable
end

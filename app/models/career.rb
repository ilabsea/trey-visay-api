# frozen_string_literal: true
# == Schema Information
#
# Table name: careers
#
#  id                 :integer          not null, primary key
#  name               :string(255)      not null
#  description        :string(255)
#  places_for_work    :string(255)
#  categorizable_type :string(255)
#  categorizable_id   :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_careers_on_categorizable_type_and_categorizable_id  (categorizable_type,categorizable_id)
#

class Career < ApplicationRecord
  belongs_to :categorizable, polymorphic: true
  has_and_belongs_to_many :schools
  has_and_belongs_to_many :games

  validates :name, presence: true
end

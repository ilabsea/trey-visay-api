# frozen_string_literal: true

# == Schema Information
#
# Table name: games
#
#  id                :bigint(8)        not null, primary key
#  user_id           :integer          not null
#  characteristic_id :integer
#  reason            :string(255)
#  audio             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_date      :datetime
#  goal              :string(255)
#

class Game < ApplicationRecord
  belongs_to :user
  belongs_to :characteristic
  has_many :personal_understandings, dependent: :destroy
  has_many :career_games
  has_many :careers, through: :career_games
  has_and_belongs_to_many :entries
  has_one :subject, dependent: :destroy

  accepts_nested_attributes_for :personal_understandings
  accepts_nested_attributes_for :career_games
  accepts_nested_attributes_for :subject

  accepts_nested_attributes_for :personal_understandings
  accepts_nested_attributes_for :career_games
  accepts_nested_attributes_for :subject

  mount_uploader :audio, ::AudioUploader

  def schools
    @schools ||= goal_career.try(:schools) || []
  end

  def goal_career
    @goal_career ||= career_games.find_by(is_goal: true).try(:career)
  end
end

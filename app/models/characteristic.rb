# frozen_string_literal: true

# == Schema Information
#
# Table name: characteristics
#
#  id               :bigint(8)        not null, primary key
#  title            :string(255)      not null
#  description      :text(65535)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  concern_subjects :text(65535)
#

class Characteristic < ApplicationRecord
  has_many :characteristics_entries, class_name: 'CharacteristicsEntry'
  has_many :entries, through: :characteristics_entries

  has_many :characteristics_entries_concerned, -> { where concerned: true }, class_name: 'CharacteristicsEntry'
  has_many :concerned_entries, through: :characteristics_entries_concerned, class_name: 'Entry', source: :entry

  has_many :careers, as: :categorizable
  has_many :games

  serialize :concern_subjects, Array
end

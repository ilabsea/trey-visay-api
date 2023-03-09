# frozen_string_literal: true

# == Schema Information
#
# Table name: entries
#
#  id   :bigint(8)        not null, primary key
#  name :string(255)      not null
#

class Entry < ApplicationRecord
  has_many :characteristics_entries
  has_many :characteristics, through: :characteristics_entries

  has_and_belongs_to_many :games
end

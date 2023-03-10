# frozen_string_literal: true

# == Schema Information
#
# Table name: characteristics_entries
#
#  characteristic_id :bigint(8)
#  entry_id          :bigint(8)
#  id                :bigint(8)        not null, primary key
#  concerned         :boolean          default(FALSE)
#
# Indexes
#
#  index_characteristics_entries_on_characteristic_id  (characteristic_id)
#  index_characteristics_entries_on_entry_id           (entry_id)
#

class CharacteristicsEntry < ApplicationRecord
  belongs_to :entry
  belongs_to :characteristic
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: importing_items
#
#  id            :bigint(8)        not null, primary key
#  itemable_id   :string(255)
#  itemable_type :string(255)
#  batch_id      :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ImportingItem < ApplicationRecord
  # Association
  belongs_to :itemable, polymorphic: true, autosave: true
  belongs_to :batch

  def itemable_attributes=(attributes)
    self.itemable ||= itemable_type.constantize.new
    self.itemable.assign_attributes(attributes)
    self.itemable.save if self.itemable.persisted?
  end
end

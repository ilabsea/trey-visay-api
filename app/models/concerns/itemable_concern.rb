# frozen_string_literal: true

module ItemableConcern
  extend ActiveSupport::Concern

  included do
    # Association
    has_many :importing_items, as: :itemable
    has_many :batches, through: :importing_items
  end
end

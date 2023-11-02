# frozen_string_literal: true

class AddDisplayOrderToHollandScores < ActiveRecord::Migration[6.0]
  def change
    add_column :holland_scores, :display_order, :integer
  end
end

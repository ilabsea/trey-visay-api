# frozen_string_literal: true

class AddScoreToSelfUnderstandingOptions < ActiveRecord::Migration[5.2]
  def change
    add_column :self_understanding_options, :score, :integer
  end
end

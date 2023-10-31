# frozen_string_literal: true

class AddRecommendationToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :recommendation, :text
  end
end

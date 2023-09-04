# frozen_string_literal: true

class AddMajorIdToHollandMajorResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :holland_major_responses, :major_id, :integer
    remove_column :holland_major_responses, :college_major_id
  end
end

# frozen_string_literal: true

class AddRelevantToSelfUnderstandingQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :self_understanding_questions, :relevant, :string
  end
end

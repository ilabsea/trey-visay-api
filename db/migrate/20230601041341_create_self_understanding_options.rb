# frozen_string_literal: true

class CreateSelfUnderstandingOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :self_understanding_options, id: :string do |t|
      t.string :code
      t.string :name
      t.string :value
      t.string :self_understanding_question_id
      t.integer :display_order, default: 1

      t.timestamps
    end
  end
end

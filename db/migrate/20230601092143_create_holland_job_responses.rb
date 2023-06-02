# frozen_string_literal: true

class CreateHollandJobResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :holland_job_responses, id: :string do |t|
      t.string :holland_quiz_id
      t.string :job_id
      t.boolean :selected

      t.timestamps
    end
  end
end

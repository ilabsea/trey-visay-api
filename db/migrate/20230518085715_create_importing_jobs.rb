# frozen_string_literal: true

class CreateImportingJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :importing_jobs do |t|
      t.string :job_id
      t.string :job_batch_id

      t.timestamps
    end
  end
end

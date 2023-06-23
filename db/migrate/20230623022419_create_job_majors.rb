# frozen_string_literal: true

class CreateJobMajors < ActiveRecord::Migration[5.2]
  def change
    create_table :job_majors do |t|
      t.string  :job_id
      t.integer :major_id

      t.timestamps
    end
  end
end

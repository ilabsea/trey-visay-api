# frozen_string_literal: true

class CreateJobClusters < ActiveRecord::Migration[5.2]
  def change
    create_table :job_clusters, id: :string do |t|
      t.string  :code
      t.string  :name
      t.integer :display_order

      t.timestamps
    end
  end
end

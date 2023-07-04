# frozen_string_literal: true

class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits, id: :string do |t|
      t.string   :page_id
      t.integer  :user_id
      t.datetime :visit_date
      t.string   :pageable_id
      t.string   :pageable_type

      t.timestamps
    end
  end
end

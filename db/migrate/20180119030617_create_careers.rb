# frozen_string_literal: true

class CreateCareers < ActiveRecord::Migration[5.1]
  def change
    create_table :careers do |t|
      t.string     :name,                 null: false
      t.text       :description
      t.string     :places_for_work
      t.references :categorizable, polymorphic: true, index: true
      t.text       :unknown_schools

      t.timestamps
    end
  end
end

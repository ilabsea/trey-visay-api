# frozen_string_literal: true

class CreatePersonalityCategoryCareers < ActiveRecord::Migration[5.1]
  def change
    create_table :personality_category_careers do |t|
      t.string :personality_category_code
      t.string :career_code
    end
  end
end

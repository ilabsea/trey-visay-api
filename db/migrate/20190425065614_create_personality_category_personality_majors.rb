# frozen_string_literal: true

class CreatePersonalityCategoryPersonalityMajors < ActiveRecord::Migration[5.1]
  def change
    create_table :personality_category_personality_majors do |t|
      t.string :personality_category_code
      t.string :personality_major_code
    end
  end
end

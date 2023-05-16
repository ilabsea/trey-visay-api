# frozen_string_literal: true

class AddCareerCodeIndexToCareers < ActiveRecord::Migration[5.1]
  def change
    add_index :careers, :code, unique: true
  end
end

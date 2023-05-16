# frozen_string_literal: true

class AddShortDescriptionToCareers < ActiveRecord::Migration[5.1]
  def change
    add_column :careers, :short_description, :text
    add_column :careers, :duty, :text
    add_column :careers, :working_environment, :text
    add_column :careers, :training_level, :string
    add_column :careers, :salary, :string
  end
end

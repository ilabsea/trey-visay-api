# frozen_string_literal: true

class AddIsSelectedMajorOrCareerToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_selected_major_or_career, :boolean
  end
end

# frozen_string_literal: true

class AddVersionToLog < ActiveRecord::Migration[5.1]
  def change
    add_column :logs, :version, :string
  end
end

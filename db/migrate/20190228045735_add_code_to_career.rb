# frozen_string_literal: true

class AddCodeToCareer < ActiveRecord::Migration[5.1]
  def change
    add_column :careers, :code, :string
  end
end

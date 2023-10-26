# frozen_string_literal: true

class AddDeletedAtToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :deleted_at, :datetime
  end
end

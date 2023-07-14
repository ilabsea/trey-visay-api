# frozen_string_literal: true

class AddDeviceOsToVisits < ActiveRecord::Migration[5.2]
  def change
    add_column :visits, :device_os, :integer
  end
end

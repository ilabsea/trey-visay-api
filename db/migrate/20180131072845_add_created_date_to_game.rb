class AddCreatedDateToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :created_date, :datetime
  end
end

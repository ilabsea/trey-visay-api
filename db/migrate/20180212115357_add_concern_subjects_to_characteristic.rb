class AddConcernSubjectsToCharacteristic < ActiveRecord::Migration[5.1]
  def change
    add_column :characteristics, :concern_subjects, :text
  end
end

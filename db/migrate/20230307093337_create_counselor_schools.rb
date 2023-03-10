class CreateCounselorSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :counselor_schools do |t|
      t.string :name

      t.timestamps
    end
  end
end

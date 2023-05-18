class CreateMiddleSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :middle_schools, id: :string, limit: 8 do |t|
      t.string :code
      t.string :name
      t.string :province_id
      t.string :district_id
      t.string :commune_id

      t.timestamps
    end
  end
end

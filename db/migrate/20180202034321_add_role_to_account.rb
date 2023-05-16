class AddRoleToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :is_admin, :boolean, default: false
    add_column :accounts, :is_counsellor, :boolean, default: false
    add_column :accounts, :schools, :text
  end
end

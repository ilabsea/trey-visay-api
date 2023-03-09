class AddConfirmableToAccounts < ActiveRecord::Migration[5.2]
  def up
    ## Database authenticatable
    change_column :accounts, :encrypted_password, :string, null: true

    ## Confirmable
    add_column :accounts, :confirmation_token, :string
    add_column :accounts, :confirmed_at, :datetime
    add_column :accounts, :confirmation_sent_at, :datetime
    add_column :accounts, :unconfirmed_email, :string # Only if using reconfirmable

    add_column :accounts, :role, :integer
    add_column :accounts, :deleted_at, :datetime
    add_column :accounts, :locale, :string
    add_column :accounts, :counselor_school_id, :string
  end

  def down
    ## Database authenticatable
    change_column :accounts, :encrypted_password, :string, null: false

    ## Confirmable
    remove_column :accounts, :confirmation_token
    remove_column :accounts, :confirmed_at
    remove_column :accounts, :confirmation_sent_at
    remove_column :accounts, :unconfirmed_email

    remove_column :accounts, :role
    remove_column :accounts, :deleted_at
    remove_column :accounts, :locale
    remove_column :accounts, :counselor_school_id
  end
end

class AddAuthenticationTokenToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :authentication_token, :string
    add_column :accounts, :token_expired_date, :datetime
  end
end

# frozen_string_literal: true

accounts = [
  {
    email: "sokly@kawsang.com",
    password: "123456",
    password_confirmation: "123456",
    is_admin: true,
    role: "primary_admin"
  },
  {
    email: "sokly1@kawsang.com",
    password: "123456",
    password_confirmation: "123456",
    role: "admin"
  }
]

accounts.each do |account|
  acc = Account.create!(account)
  acc.confirm
end

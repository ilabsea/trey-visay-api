# frozen_string_literal: true

accounts = [
  {
    email: "admin@kawsang.com",
    role: "primary_admin"
  },
  {
    email: "sokly@kawsang.com",
    role: "admin"
  }
]

accounts.each do |account|
  acc = ::Account.new(account.merge({ password: "123456" }))
  acc.confirm
end

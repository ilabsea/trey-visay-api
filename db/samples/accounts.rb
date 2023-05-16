# frozen_string_literal: true

accounts = [
  {
    email: "sokly@instedd.org",
    password: "123456",
    password_confirmation: "123456",
    is_admin: true
  },
  {
    email: "mesa@instedd.org",
    password: "123456",
    password_confirmation: "123456"
  }
]

accounts.each do |account|
  Account.create!(account)
end

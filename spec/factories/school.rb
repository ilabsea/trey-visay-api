# frozen_string_literal: true

FactoryBot.define do
  factory :school do
    name                { FFaker::Name.name }
    address             { FFaker::Address.street_name }
    phone_numbers       { FFaker::PhoneNumber.phone_number }
    emails              { FFaker::Internet.email }
    website_or_facebook { FFaker::Internet.http_url }
    category            { %w(public private ngo).sample }
    kind                { "higher_education" }
  end
end

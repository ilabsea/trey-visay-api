# frozen_string_literal: true

FactoryBot.define do
  factory :entry do
    name  { FFaker::Name.name }
  end
end

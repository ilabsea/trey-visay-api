# frozen_string_literal: true

# == Schema Information
#
# Table name: self_understanding_questions
#
#  id            :string(255)      not null, primary key
#  code          :string(255)
#  name          :string(255)
#  type          :string(255)
#  display_order :integer          default(1)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  relevant      :string(255)
#
FactoryBot.define do
  factory :self_understanding_question do
    name { "តើប្អូននឹងបន្ដការសិក្សារហូតដល់បញ្ចប់ថ្នាក់ ឬកម្រិតណាដែរ?" }
    type { "Fields::SelectoneField" }

    trait :with_options do
      after(:create) do |question, evaluator|
        options = [{ name: "ថ្នាក់ទី១២", value: "grade12" }, { name: "ឧត្តមសិក្សា", value: "higher" }, { name: "មិនច្បាស់", value: "unsure" }]
        options.each do |option|
          question.options.create(name: option[:name], value: option[:value])
        end
      end
    end

    trait :q1 do
      code { "q1" }
      name { "១) តើប្អូននឹងបន្ដការសិក្សារហូតដល់បញ្ចប់ថ្នាក់ ឬកម្រិតណាដែរ?" }

      after(:create) do |question, evaluator|
        options = [{ name: "ថ្នាក់ទី១២", value: "grade12" }, { name: "ឧត្តមសិក្សា", value: "higher" }, { name: "មិនច្បាស់", value: "unsure" }]
        options.each do |option|
          question.options.create(name: option[:name], value: option[:value])
        end
      end
    end

    trait :q2 do
      code { "q2" }
      name { "២) តើឪពុកម្ដាយប្អូន នឹងអនុញ្ញាតឱ្យប្អូនបន្ដការសិក្សារហូតដល់ចប់ថ្នាក់ ឬកម្រិតណាដែរ?" }

      after(:create) do |question, evaluator|
        options = [{ name: "ថ្នាក់ទី១២", value: "grade12" }, { name: "ឧត្តមសិក្សា", value: "higher" }, { name: "មិនច្បាស់", value: "unsure" }]
        options.each do |option|
          question.options.create(name: option[:name], value: option[:value])
        end
      end
    end
  end
end

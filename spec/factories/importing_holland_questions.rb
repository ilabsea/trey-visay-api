# frozen_string_literal: true

# == Schema Information
#
# Table name: importing_holland_questions
#
#  id                        :bigint(8)        not null, primary key
#  holland_question_id       :string(255)
#  holland_question_batch_id :string(255)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
FactoryBot.define do
  factory :importing_holland_question do
  end
end

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
class ImportingHollandQuestion < ApplicationRecord
  belongs_to :holland_question
  belongs_to :holland_question_batch

  accepts_nested_attributes_for :holland_question
end

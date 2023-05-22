# frozen_string_literal: true

# == Schema Information
#
# Table name: holland_question_batches
#
#  id          :string(255)      not null, primary key
#  code        :string(255)
#  total_count :integer          default(0)
#  valid_count :integer          default(0)
#  new_count   :integer          default(0)
#  reference   :string(255)
#  creator_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class HollandQuestionBatch < ApplicationRecord
  include BatchConcern

  # Association
  has_many :importing_holland_questions, inverse_of: :holland_question_batch, dependent: :destroy
  has_many :holland_questions, through: :importing_holland_questions

  # Nested attributes
  accepts_nested_attributes_for :importing_holland_questions
end

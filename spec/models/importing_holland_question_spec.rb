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
require "rails_helper"

RSpec.describe ImportingHollandQuestion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

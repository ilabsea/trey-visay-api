# frozen_string_literal: true

# == Schema Information
#
# Table name: holland_responses
#
#  id                    :string(255)      not null, primary key
#  holland_quiz_id       :string(255)
#  holland_question_id   :string(255)
#  holland_question_code :string(255)
#  value                 :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require "rails_helper"

RSpec.describe HollandResponse, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

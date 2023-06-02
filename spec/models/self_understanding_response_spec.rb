# == Schema Information
#
# Table name: self_understanding_responses
#
#  id                               :string(255)      not null, primary key
#  holland_quiz_id                  :string(255)
#  self_understanding_question_id   :string(255)
#  self_understanding_question_code :string(255)
#  value                            :string(255)
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
require 'rails_helper'

RSpec.describe SelfUnderstandingResponse, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

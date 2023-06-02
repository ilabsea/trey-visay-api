# frozen_string_literal: true

# == Schema Information
#
# Table name: holland_quizzes
#
#  id                        :string(255)      not null, primary key
#  user_id                   :integer
#  personality_type_results  :string(255)
#  college_major_id          :string(255)
#  job_id                    :string(255)
#  quizzed_at                :datetime
#  selected_college_major_at :datetime
#  selected_job_at           :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
require "rails_helper"

RSpec.describe HollandQuiz, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

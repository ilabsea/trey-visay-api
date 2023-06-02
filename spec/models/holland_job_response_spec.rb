# == Schema Information
#
# Table name: holland_job_responses
#
#  id              :string(255)      not null, primary key
#  holland_quiz_id :string(255)
#  job_id          :string(255)
#  selected        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe HollandJobResponse, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

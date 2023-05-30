# frozen_string_literal: true

# == Schema Information
#
# Table name: college_major_batches
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
require "rails_helper"

RSpec.describe CollegeMajorBatch, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

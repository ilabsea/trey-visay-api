# frozen_string_literal: true

# == Schema Information
#
# Table name: importing_schools
#
#  id              :bigint(8)        not null, primary key
#  school_id       :integer
#  school_batch_id :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "rails_helper"

RSpec.describe ImportingSchool, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

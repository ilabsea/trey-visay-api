# == Schema Information
#
# Table name: importing_middle_schools
#
#  id                     :bigint(8)        not null, primary key
#  middle_school_id       :string(255)
#  middle_school_batch_id :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe ImportingMiddleSchool, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

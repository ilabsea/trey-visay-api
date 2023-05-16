# == Schema Information
#
# Table name: departments
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  school_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "rails_helper"

RSpec.describe Department, type: :model do
  it { is_expected.to belong_to(:school) }
  it { is_expected.to have_many(:majors) }
  it { is_expected.to validate_presence_of(:name) }
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: departments
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  grade      :integer
#

require "rails_helper"

RSpec.describe Department, type: :model do
  it { is_expected.to have_many(:school_departments) }
  it { is_expected.to have_many(:schools).through(:school_departments) }
  it { is_expected.to validate_presence_of(:name) }
end

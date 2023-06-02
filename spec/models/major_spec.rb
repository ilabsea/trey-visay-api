# frozen_string_literal: true

# == Schema Information
#
# Table name: majors
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "rails_helper"

RSpec.describe Major, type: :model do
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_many(:major_mappings) }
  it { is_expected.to have_many(:college_majors).through(:major_mappings) }

  it { is_expected.to have_many(:school_majors) }
  it { is_expected.to have_many(:schools).through(:school_majors) }
  it { is_expected.to have_many(:school_departments).through(:school_majors) }
end

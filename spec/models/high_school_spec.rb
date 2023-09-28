require "rails_helper"

RSpec.describe HighSchool, type: :model do
  it { is_expected.to validate_presence_of(:name_km) }
  it { is_expected.to validate_presence_of(:district_id) }
end

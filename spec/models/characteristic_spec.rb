# == Schema Information
#
# Table name: characteristics
#
#  id               :bigint(8)        not null, primary key
#  title            :string(255)      not null
#  description      :text(65535)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  concern_subjects :text(65535)
#

require "rails_helper"

RSpec.describe Characteristic, type: :model do
  it { is_expected.to have_many(:entries) }
  it { is_expected.to have_many(:careers) }
  it { is_expected.to have_many(:games) }
end

# == Schema Information
#
# Table name: vocationals
#
#  id          :bigint(8)        not null, primary key
#  title       :string(255)      not null
#  description :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Vocational, type: :model do
  it { is_expected.to have_many(:careers) }
end

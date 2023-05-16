# == Schema Information
#
# Table name: entries
#
#  id   :bigint(8)        not null, primary key
#  name :string(255)      not null
#

require "rails_helper"

RSpec.describe Entry, type: :model do
  it { is_expected.to have_many(:characteristics) }
  it { is_expected.to have_and_belong_to_many(:games) }
end

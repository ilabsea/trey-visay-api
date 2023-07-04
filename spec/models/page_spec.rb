# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id             :string(255)      not null, primary key
#  code           :string(255)
#  name_km        :string(255)
#  name_en        :string(255)
#  parent_id      :string(255)
#  visits_count   :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_pages_on_lft  (lft)
#  index_pages_on_rgt  (rgt)
#
require "rails_helper"

RSpec.describe Page, type: :model do
  it { is_expected.to have_many(:visits) }
end

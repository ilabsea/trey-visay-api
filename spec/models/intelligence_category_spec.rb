# frozen_string_literal: true

# == Schema Information
#
# Table name: intelligence_categories
#
#  id                          :string(255)      not null, primary key
#  code                        :string(255)
#  name_km                     :string(255)
#  name_en                     :string(255)
#  description                 :text(65535)
#  appropriate_learning_method :text(65535)
#  suitable_job                :text(65535)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#
require "rails_helper"

RSpec.describe IntelligenceCategory, type: :model do
  it { is_expected.to validate_presence_of(:name_km) }
  it { is_expected.to validate_presence_of(:name_en) }
end

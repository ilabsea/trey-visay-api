# == Schema Information
#
# Table name: personality_categories
#
#  code        :string(36)       not null, primary key
#  name_en     :string(255)
#  name_km     :string(255)
#  group       :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe PersonalityCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

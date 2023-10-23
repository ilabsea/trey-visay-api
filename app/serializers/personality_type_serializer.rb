# frozen_string_literal: true

# == Schema Information
#
# Table name: personality_types
#
#  id                :string(255)      not null, primary key
#  code              :string(255)
#  name_km           :string(255)
#  name_en           :string(255)
#  recommendation    :text(65535)
#  description       :text(65535)
#  personal_value    :text(65535)
#  skill_and_ability :text(65535)
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class PersonalityTypeSerializer < ActiveModel::Serializer
  attributes :id, :code, :name_km, :name_en, :description,
             :personal_value, :skill_and_ability, :recommendation,
             :updated_at, :deleted_at
end

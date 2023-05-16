# frozen_string_literal: true

# == Schema Information
#
# Table name: careers
#
#  id                  :bigint(8)        not null, primary key
#  name                :string(255)      not null
#  description         :text(65535)
#  places_for_work     :string(255)
#  categorizable_type  :string(255)
#  categorizable_id    :bigint(8)
#  unknown_schools     :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  code                :string(255)
#  short_description   :text(65535)
#  duty                :text(65535)
#  working_environment :text(65535)
#  training_level      :string(255)
#  salary              :string(255)
#
# Indexes
#
#  index_careers_on_categorizable_type_and_categorizable_id  (categorizable_type,categorizable_id)
#  index_careers_on_code                                     (code) UNIQUE
#

FactoryBot.define do
  factory :career do
    name          { FFaker::Name.name }
    description   { FFaker::Lorem.paragraphs(1 + Kernel.rand(5)).join("\n") }
    association :categorizable, :characteristic
    code { FFaker::Name.name }
  end
end

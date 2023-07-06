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
FactoryBot.define do
  factory :intelligence_category do
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: intelligence_questions
#
#  id                       :string(255)      not null, primary key
#  code                     :string(255)
#  name                     :string(255)
#  intelligence_category_id :string(255)
#  display_order            :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class IntelligenceQuestionSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :display_order

  belongs_to :intelligence_category
end

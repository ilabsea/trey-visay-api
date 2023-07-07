# frozen_string_literal: true

module IntelligenceQuizzes::NestedAttributeConcern
  extend ActiveSupport::Concern

  included do
    def intelligence_scores_attributes=(attributes)
      attributes.each do |attribute|
        param = {
          intelligence_category_id: IntelligenceCategory.find_by(code: attribute[:intelligence_category_code]).try(:id),
          score: attribute[:score]
        }

        self.intelligence_scores.new(param)
      end
    end

    def intelligence_responses_attributes=(attributes)
      attributes.each do |attribute|
        attribute[:intelligence_question_id] ||= IntelligenceQuestion.find_by(code: attribute[:intelligence_question_code]).try(:id)

        self.intelligence_responses.new(attribute)
      end
    end
  end
end

# frozen_string_literal: true

require_relative "base"

module Sample
  class IntelligenceQuiz
    def initialize(user)
      @user = user
    end

    def simulate(count = 1)
      count.times.each do |i|
        create_intelligence_quiz
      end
    end

    private
      def create_intelligence_quiz
        ::IntelligenceQuiz.create(
          user: @user,
          quizzed_at: @user.registered_at + rand(1..20).minutes,
          intelligence_responses_attributes: intelligence_responses_attributes,
          intelligence_scores_attributes: intelligence_scores_attributes,
        )
      end

      def intelligence_responses_attributes
        @intelligence_responses_attributes ||= intelligence_questions.map do |question|
          {
            intelligence_question_code: question.code,
            value: rand(1..5)
          }
        end
      end

      def intelligence_questions
        @intelligence_questions ||= ::IntelligenceQuestion.all
      end

      def intelligence_scores_attributes
        IntelligenceCategory.all.map do |category|
          question_codes = intelligence_questions.select { |question| question.intelligence_category_id == category.id }.pluck(:code)
          {
            intelligence_category_code: category.code,
            score: intelligence_responses_attributes.select { |res| question_codes.include?(res[:intelligence_question_code]) }.sum { |res| res[:value] }
          }
        end
      end
  end
end

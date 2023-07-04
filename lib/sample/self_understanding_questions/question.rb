# frozen_string_literal: true

module Sample
  module SelfUnderstandingQuestions
    class Question
      def process(row)
        question = ::SelfUnderstandingQuestion.find_or_initialize_by(code: row["code"])
        question.update({
          name: row["name"],
          type: row["type"],
          relevant: row["relevant"]
        })
      end
    end
  end
end

module Sample
  module SelfUnderstandingQuestions
    class Option
      def process(row)
        question = ::SelfUnderstandingQuestion.find_by_code(row["question_code"])
        return unless question.present?

        option = question.options.find_or_initialize_by(code: row["code"])
        option.update(name: row["name"], value: row["value"])
      end
    end
  end
end

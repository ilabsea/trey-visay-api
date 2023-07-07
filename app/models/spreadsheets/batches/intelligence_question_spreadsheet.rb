# frozen_string_literal: true

module Spreadsheets
  module Batches
    class IntelligenceQuestionSpreadsheet
      attr_reader :question

      def initialize(question)
        @question = question
      end

      def process(row)
        question.attributes = {
          code: row["code"],
          name: row["name"],
          intelligence_category_id: IntelligenceCategory.find_by(code: row["intelligence_category_code"]).try(:id)
        }

        question
      end
    end
  end
end

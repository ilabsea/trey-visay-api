# frozen_string_literal: true

module Spreadsheets
  module Batches
    class HollandQuestionSpreadsheet
      attr_reader :question

      def initialize(question)
        @question = question
      end

      def process(row)
        question.attributes = {
          code: row["code"],
          name: row["name"],
          personality_type: row["personality_type"].upcase
        }
        question
      end
    end
  end
end

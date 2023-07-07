# frozen_string_literal: true

class IntelligenceQuestionImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_type
      "IntelligenceQuestionBatch"
    end

    def redirect_success_url
      intelligence_questions_url
    end

    def redirect_error_url
      new_intelligence_question_importer_url
    end

    def itemable_attributes
      [ :id, :code, :name, :intelligence_category_id ]
    end
end

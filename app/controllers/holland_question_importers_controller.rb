# frozen_string_literal: true

class HollandQuestionImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_type
      "HollandQuestionBatch"
    end

    def redirect_success_url
      holland_questions_url
    end

    def redirect_error_url
      new_holland_question_importer_url
    end

    def itemable_attributes
      [ :id, :code, :name, :personality_type ]
    end
end

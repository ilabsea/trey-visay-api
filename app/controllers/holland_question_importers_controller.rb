# frozen_string_literal: true

class HollandQuestionImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_model
      Batches::HollandQuestionBatch
    end

    def itemables_url
      holland_questions_url
    end

    def new_importer_url
      new_holland_question_importer_url
    end

    def itemable_attributes
      [ :id, :code, :name, :personality_type ]
    end
end

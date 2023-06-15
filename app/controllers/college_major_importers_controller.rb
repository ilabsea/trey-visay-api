# frozen_string_literal: true

class CollegeMajorImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_model
      Batches::CollegeMajorBatch
    end

    def redirect_success_url
      college_majors_url
    end

    def redirect_error_url
      new_college_major_importer_url
    end

    def itemable_attributes
      [
        :id, :code, :name, :personality_type,
        :general_info, :orien_orientation_subjects, :orien_study_condition,
        :orien_graduation_condition, :curriculum, :teaching_and_learning_process,
        :gain_knowledge, :worthy_career, :recommendation
      ]
    end
end

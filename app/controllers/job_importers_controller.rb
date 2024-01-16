# frozen_string_literal: true

class JobImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_type
      "JobBatch"
    end

    def redirect_success_url
      jobs_url
    end

    def redirect_error_url
      new_job_importer_url
    end

    def itemable_attributes
      [
        :id, :code, :name_km, :name_en, :job_cluster_id, :personality_type,
        :general_description,
        :jd_main_task,
        :jd_environment,
        :jd_work_style,
        :edu_education_level,
        :edu_subjects_at_high_school,
        :edu_majors_at_university,
        :personal_competency_knowledge,
        :personal_competency_skill,
        :personal_competency_ability,
        :recommendation,
        :logo_cache,
        job_majors_attributes: [major_attributes: [:name]]
      ]
    end
end

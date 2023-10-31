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
        :general_description, :jd_main_task, :jd_environment,
        :jd_technology_skill, :edu_education_level, :recommendation,
        :edu_high_school_supported_subject, :edu_higher_education_skill,
        :qua_supported_knowledge, :qua_supported_skill,
        :qua_supported_capacity, :qua_characteristic_of_job,
        :info_job_market, :info_similar_job, :logo_cache,
        job_majors_attributes: [major_attributes: [:name]]
      ]
    end
end

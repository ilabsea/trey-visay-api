# frozen_string_literal: true

class AddColumnJdWorkStyleToJobs < ActiveRecord::Migration[5.2]
  def change
    rename_column :jobs, :jd_technology_skill, :jd_work_style

    rename_column :jobs, :edu_high_school_supported_subject, :edu_subjects_at_high_school
    rename_column :jobs, :edu_higher_education_skill, :edu_majors_at_university

    rename_column :jobs, :qua_supported_knowledge, :personal_competency_knowledge
    rename_column :jobs, :qua_supported_skill, :personal_competency_skill
    rename_column :jobs, :qua_supported_capacity, :personal_competency_ability

    remove_column :jobs, :qua_characteristic_of_job
    remove_column :jobs, :info_job_market
    remove_column :jobs, :info_similar_job
  end
end

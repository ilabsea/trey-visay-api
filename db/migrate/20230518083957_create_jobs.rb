# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs, id: :string do |t|
      t.string :code
      t.string :name_km
      t.string :name_en
      t.string :personality_type
      t.text   :general_description
      t.text   :jd_main_task
      t.string :jd_environment
      t.string :jd_technology_skill
      t.string :edu_education_level
      t.string :edu_high_school_supported_subject
      t.string :edu_higher_education_skill
      t.string :qua_supported_knowledge
      t.string :qua_supported_skill
      t.string :qua_supported_capacity
      t.string :qua_characteristic_of_job
      t.text   :info_job_market
      t.text   :info_similar_job

      t.timestamps
    end
  end
end

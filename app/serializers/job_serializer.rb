# frozen_string_literal: true

# == Schema Information
#
# Table name: jobs
#
#  id                                :string(255)      not null, primary key
#  code                              :string(255)
#  name_km                           :string(255)
#  name_en                           :string(255)
#  personality_type                  :string(255)
#  general_description               :text(65535)
#  jd_main_task                      :text(65535)
#  jd_environment                    :string(255)
#  jd_technology_skill               :string(255)
#  edu_education_level               :string(255)
#  edu_high_school_supported_subject :string(255)
#  edu_higher_education_skill        :string(255)
#  qua_supported_knowledge           :string(255)
#  qua_supported_skill               :string(255)
#  qua_supported_capacity            :string(255)
#  qua_characteristic_of_job         :string(255)
#  info_job_market                   :text(65535)
#  info_similar_job                  :text(65535)
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  job_cluster_id                    :string(255)
#  logo                              :string(255)
#
class JobSerializer < ActiveModel::Serializer
  attributes :id, :code, :name_km, :name_en, :name, :personality_type,
             :logo,
             :general_description, :jd_main_task, :jd_environment,
             :jd_technology_skill, :edu_education_level,
             :edu_high_school_supported_subject, :edu_higher_education_skill,
             :qua_supported_knowledge, :qua_supported_skill,
             :qua_supported_capacity, :qua_characteristic_of_job,
             :info_job_market, :info_similar_job, :value, :updated_at

  belongs_to :job_cluster
  has_many :videos
  has_many :schools

  def value
    object.name_km
  end

  class SchoolSerializer < ActiveModel::Serializer
    attributes :id, :name, :logo, :address, :kind
  end
end

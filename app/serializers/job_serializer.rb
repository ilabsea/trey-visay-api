# frozen_string_literal: true

# == Schema Information
#
# Table name: jobs
#
#  id                            :string(255)      not null, primary key
#  code                          :string(255)
#  name_km                       :string(255)
#  name_en                       :string(255)
#  personality_type              :string(255)
#  general_description           :text(65535)
#  jd_main_task                  :text(65535)
#  jd_environment                :string(255)
#  jd_work_style                 :string(255)
#  edu_education_level           :string(255)
#  edu_subjects_at_high_school   :string(255)
#  edu_majors_at_university      :string(255)
#  personal_competency_knowledge :string(255)
#  personal_competency_skill     :string(255)
#  personal_competency_ability   :string(255)
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  job_cluster_id                :string(255)
#  logo                          :string(255)
#  deleted_at                    :datetime
#
class JobSerializer < ActiveModel::Serializer
  attributes :id, :code, :name_km, :name_en, :name, :personality_type,
             :general_description,
             :jd_main_task, :jd_environment, :jd_work_style,
             :edu_education_level, :edu_subjects_at_high_school, :edu_majors_at_university,
             :personal_competency_knowledge, :personal_competency_skill, :personal_competency_ability,
             :logo, :value, :updated_at, :deleted_at

  belongs_to :job_cluster
  has_many :videos

  def value
    object.name_km
  end
end

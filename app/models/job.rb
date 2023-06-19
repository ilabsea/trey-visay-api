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
class Job < ApplicationRecord
  include ItemableConcern

  mount_uploader :logo, ::LogoUploader

  # Validation
  validates :name_km, presence: true

  # Callback
  before_create :secure_id
  before_create :secure_code
  before_create :set_name_en

  # Association
  belongs_to :job_cluster, optional: true

  # Delegation
  delegate :name, to: :job_cluster, prefix: :job_cluster, allow_nil: true

  def name
    self["name_#{I18n.locale}"]
  end

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? OR name LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
    scope = scope.where(job_cluster_id: params[:job_cluster_id]) if params[:job_cluster_id].present?
    scope
  end

  private
    def set_name_en
      self.name_en ||= name_km
    end
end

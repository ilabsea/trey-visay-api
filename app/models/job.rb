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
  has_many :videos, through: :job_cluster
  has_many :job_majors
  has_many :majors, through: :job_majors
  has_many :schools, -> { distinct }, through: :majors
  has_many :holland_job_responses

  # Delegation
  delegate :name, :code, to: :job_cluster, prefix: :job_cluster, allow_nil: true

  # Nested attributes
  accepts_nested_attributes_for :job_majors, allow_destroy: true

  def name
    self["name_#{I18n.locale}"]
  end

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? OR name_km LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
    scope = scope.where(job_cluster_id: params[:job_cluster_id]) if params[:job_cluster_id].present?
    scope
  end

  private
    def set_name_en
      self.name_en ||= name_km
    end
end

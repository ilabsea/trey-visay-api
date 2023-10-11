# frozen_string_literal: true

# == Schema Information
#
# Table name: majors
#
#  id                            :bigint(8)        not null, primary key
#  name                          :string(255)      not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  code                          :string(255)
#  parent_code                   :string(255)
#  personality_type              :string(255)
#  general_info                  :text(65535)
#  orien_orientation_subjects    :text(65535)
#  orien_study_condition         :text(65535)
#  orien_graduation_condition    :text(65535)
#  curriculum                    :text(65535)
#  teaching_and_learning_process :text(65535)
#  gain_knowledge                :text(65535)
#  worthy_career                 :text(65535)
#  recommendation                :text(65535)
#  grade                         :integer
#  deleted_at                    :datetime
#

class Major < ApplicationRecord
  acts_as_paranoid

  include ItemableConcern
  # Enum
  enum grade: Department.grades

  # Association
  belongs_to :parent, foreign_key: :parent_code, primary_key: :code, class_name: "Major", optional: true

  has_many :school_majors
  has_many :schools, through: :school_majors
  has_many :school_departments, through: :school_majors
  has_many :departments, through: :school_majors

  # Validation
  validates :name, presence: true, uniqueness: true
  validates :code, uniqueness: true

  # Delegation
  delegate :name, to: :parent, prefix: true, allow_nil: true

  # Callback
  after_create :update_vocational_grade
  after_update :update_vocational_grade
  before_create :secure_code

  # Scope
  scope :roots, -> { where(parent_code: nil) }
  scope :having_personality_type, -> { where.not(personality_type: nil) }

  # Class method
  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? or name LIKE ?", "%#{params[:name].strip}%", "%#{params[:name].strip}%") if params[:name].present?
    scope = scope.where("updated_at >= ?", params[:updated_at]) if params[:updated_at].present?
    scope
  end

  private
    def update_vocational_grade
      update_columns(grade: (departments.vocational_grade.present? ? "vocational_grade" : nil))
    end

    def secure_code
      self.code ||= "major_#{sprintf('%04d', Major.maximum(:id).to_i.next)}"

      return unless self.class.exists?(code: code)

      self.code = SecureRandom.uuid[0..5]
      secure_code
    end
end

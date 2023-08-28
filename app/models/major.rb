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
#

class Major < ApplicationRecord
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
  validates :name, presence: true
  validates :code, uniqueness: true, allow_nil: true

  # Delegation
  delegate :name, to: :parent, prefix: true, allow_nil: true

  # Callback
  after_commit :update_vocational_grade

  # Scope
  scope :roots, -> { where(parent_code: nil) }

  # Class method
  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? or name LIKE ?", "%#{params[:name].strip}%", "%#{params[:name].strip}%") if params[:name].present?
    scope
  end

  private
    def update_vocational_grade
      update_columns(grade: (departments.vocational_grade.present? ? "vocational_grade" : nil))
    end
end

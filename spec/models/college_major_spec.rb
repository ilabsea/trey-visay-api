# frozen_string_literal: true

# == Schema Information
#
# Table name: college_majors
#
#  id                            :string(255)      not null, primary key
#  code                          :string(255)
#  name                          :string(255)
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
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#
require "rails_helper"

RSpec.describe CollegeMajor, type: :model do
  it { is_expected.to validate_presence_of(:name) }
end

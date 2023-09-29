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
FactoryBot.define do
  factory :major do
    name { FFaker::Name.name }
    personality_type { "ESA" }
  end
end

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
#
require "rails_helper"

RSpec.describe Job, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

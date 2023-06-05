# frozen_string_literal: true

namespace :college_major do
  desc "Mapping college_major with major"
  task mapping_with_major: :environment do
    CollegeMajor.find_each do |college_major|
      college_major.major_ids = Major.where(name: college_major.name).pluck(:id)
    end

    puts "Mapping is done!"
  end
end

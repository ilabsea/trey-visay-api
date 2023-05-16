# frozen_string_literal: true

namespace :career do
  desc "Migrate code to careers"
  task migrate_code: :environment do
    puts("Career code is migrating")

    filenames = ["career_science.csv", "career_social.csv", "career_technical.csv", "career_vocational.csv"]
    filenames.each do |filename|
      print(".")
      Career.append_field_with_csv(filename, "code", "name")
    end

    puts("Career code migration is completed!")
  end

  desc "Reverse migrate code to careers"
  task reverse_migrate_code: :environment do
    puts("Reverse career code is processing")

    Career.all.each do |career|
      career.code = nil
      career.save
    end

    puts("Reverse career code is completed!")
  end

  desc "create or update careers"
  task load: :environment do
    options = {}
    Sample::Career.load("career_science", options.merge(category: "បុគ្គលិកលក្ខណៈបុគ្គលបែប វិទ្យាសាស្រ្ត"))
    Sample::Career.load("career_technical", options.merge(category: "បុគ្គលិកលក្ខណៈបុគ្គលបែប បច្ចេកទេស"))
    Sample::Career.load("career_social", options.merge(category: "បុគ្គលិកលក្ខណៈបុគ្គល បែបសង្គម"))
    Sample::Career.load("career_vocational", options.merge(group: "Vocational", category: "វិជ្ជាជីវៈ"))
  end
end

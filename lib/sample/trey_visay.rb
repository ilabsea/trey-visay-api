# frozen_string_literal: true

require_relative "execute"
require_relative "university"
require_relative "career"
require_relative "high_school"
require_relative "personality"
require_relative "personality_category"
require_relative "personality_major"

module Sample
  class TreyVisay
    def self.load_samples(options = {})
      options.reverse_merge!(verbose: true)

      Sample::Execute.load("accounts", options)

      # V1
      # Sample::Execute.load("subject_tips", options)
      # Sample::Execute.load("entries", options)
      # Sample::Execute.load("characteristic_jobs", options)
      # Sample::Execute.load("vocational_jobs", options)
      # Sample::University.load("university", options) //run it now will be error as we change schema
      # Sample::Career.load("career_science", options.merge(category: "បុគ្គលិកលក្ខណៈបុគ្គលបែប វិទ្យាសាស្រ្ត"))
      # Sample::Career.load("career_technical", options.merge(category: "បុគ្គលិកលក្ខណៈបុគ្គលបែប បច្ចេកទេស"))
      # Sample::Career.load("career_social", options.merge(category: "បុគ្គលិកលក្ខណៈបុគ្គល បែបសង្គម"))
      # Sample::Career.load("career_vocational", options.merge(group: "Vocational", category: "វិជ្ជាជីវៈ"))
      # Sample::HigherCareer.load("higher_careers", options)
      # Sample::HighSchool.load("high_school", options)
      # Sample::Personality.load("personality", options)
      # Major must loaded before category in order to assign dependency
      # Sample::PersonalityMajor.load("major_options_for_higher_education", options)
      # Sample::PersonalityCategory.load("personality_category_majors_and_careers", options)

      # V2
      Sample::SelfUnderstandingQuestion.new.import
    end

    def self.export_samples
      Sample::University.export
      Sample::Career.export
      Sample::HighSchool.export
      Sample::Location.export
      Sample::Personality.export
      Sample::PersonalityCategory.export
      Sample::PersonalityMajor.export
    end
  end
end

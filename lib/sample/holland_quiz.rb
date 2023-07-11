# frozen_string_literal: true

require_relative "base"

module Sample
  class HollandQuiz
    def initialize(user)
      @user = user
    end

    def simulate(count = 1)
      count.times.each do |i|
        create_holland_quiz
      end
    end

    private
      def create_holland_quiz
        quizzed_at = @user.registered_at + rand(1..20).minutes

        ::HollandQuiz.create(
          user: @user,
          quizzed_at: quizzed_at,
          finished_at: quizzed_at + rand(10..20).minutes,
          self_understanding_responses_attributes: self_understanding_responses_attributes,
          holland_responses_attributes: holland_responses_attributes,
          holland_scores_attributes: holland_scores_attributes,
          holland_major_responses_attributes: holland_major_responses_attributes,
          holland_job_responses_attributes: holland_job_responses_attributes
        )
      end

      def holland_major_responses_attributes
        majors = ::CollegeMajor.where("personality_type LIKE ?", "#{top_personality_type}%").sample(3)
        majors.map.with_index do |major, index|
          {
            college_major_code: major.code,
            selected: index == 0
          }
        end
      end

      def holland_job_responses_attributes
        jobs = ::Job.where("personality_type LIKE ?", "#{top_personality_type}%").sample(3)
        jobs.map.with_index do |job, index|
          {
            job_code: job.code,
            selected: index == 0
          }
        end
      end

      def top_personality_type
        @top_personality_type ||= holland_scores_attributes.sort_by { |k| -k[:score] }.first[:personality_type]
      end

      def self_understanding_responses_attributes
        ::SelfUnderstandingQuestion.all.map do |question|
          {
            self_understanding_question_code: question.code,
            value: question.options.sample.try(:value) || Job.all.sample.name_km
          }
        end
      end

      def holland_responses_attributes
        @holland_responses_attributes ||= holland_questions.map do |question|
          {
            holland_question_code: question.code,
            value: rand(1..5)
          }
        end
      end

      def holland_questions
        @holland_questions ||= ::HollandQuestion.all
      end

      def holland_scores_attributes
        @holland_scores_attributes ||= HollandQuestion::PERSONALITY_TYPES.map do |personality_type|
          question_codes = holland_questions.select { |question| question.personality_type == personality_type }.pluck(:code)
          {
            personality_type: personality_type,
            score: holland_responses_attributes.select { |res| question_codes.include?(res[:holland_question_code]) }.sum { |res| res[:value] }
          }
        end
      end
  end
end

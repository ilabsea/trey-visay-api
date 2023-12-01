# frozen_string_literal: true

module Users::ScheduleDeletionConcern
  extend ActiveSupport::Concern

  included do
    REMOVING_PERIOD = ENV.fetch("REMOVING_PERIOD") { 90 }

    # callback
    after_destroy :schedule_real_destroy
    after_real_destroy :remove_association

    private
      def removing_date
        @removing_date ||= deleted_at + REMOVING_PERIOD.days
      end

      def schedule_real_destroy
        UserDeletionJob.perform_at(removing_date, id)
      end

      def remove_association
        User.transaction do
          # association v1
          self.games.destroy_all
          self.personality_tests.destroy_all

          # association v2
          self.visits.destroy_all
          HollandQuiz.where(user_id: id).destroy_all
          IntelligenceQuiz.where(user_id: id).destroy_all
        end
      end
  end
end

# frozen_string_literal: true

module Majors::PersonalityTypeConcern
  extend ActiveSupport::Concern

  included do
    # Association
    has_many :major_personality_types
    has_many :personality_types, -> { reorder(display_order: :asc) }, through: :major_personality_types

    # Callback
    after_create :assign_personality_types, if: -> { personality_type.present? }
    after_update :reassign_personality_types, if: -> { saved_change_to_attribute(:personality_type) }

    private
      def assign_personality_types
        personality_type.split("").each_with_index do |code, index|
          type = PersonalityType.find_by code: code

          self.major_personality_types.create(personality_type_id: type.id, display_order: index + 1) if type.present?
        end
      end

      def reassign_personality_types
        self.major_personality_types.delete_all

        assign_personality_types
      end
  end
end

# frozen_string_literal: true

module Api
  module V2
    class PersonalityTypesController < ::Api::V2::ApiController
      def index
        pagy, personality_types = pagy(PersonalityType.filter(filter_params).with_deleted)

        render json: {
          pagy: pagy.vars,
          personality_types: ActiveModel::Serializer::CollectionSerializer.new(personality_types, serializer: PersonalityTypeSerializer)
        }
      end

      private
        def filter_params
          params.permit(:updated_at)
        end
    end
  end
end

# frozen_string_literal: true

module Api
  module V2
    class MajorsController < ::Api::V2::ApiController
      def index
        pagy, majors = pagy(Major.filter(filter_params).having_personality_type.with_deleted.includes(:schools, major_personality_types: :personality_type))

        render json: {
          pagy: pagy.vars,
          majors: ActiveModel::Serializer::CollectionSerializer.new(majors, serializer: MajorSerializer)
        }
      end

      private
        def filter_params
          params.permit(:updated_at)
        end
    end
  end
end

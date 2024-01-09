# frozen_string_literal: true

module Api
  module V2
    class HighSchoolsController < ::Api::V2::ApiController
      def index
        pagy, schools = pagy(HighSchool.filter(filter_params).exclude_v1.with_deleted)

        render json: {
          pagy: pagy.vars,
          high_schools: ActiveModel::Serializer::CollectionSerializer.new(schools, serializer: HighSchoolSerializer)
        }
      end

      private
        def filter_params
          params.permit(:updated_at)
        end
    end
  end
end

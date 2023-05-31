# frozen_string_literal: true

module Api
  module V2
    class SchoolsController < ::Api::V2::ApiController
      def index
        pagy, schools = pagy(School.filter(filter_params).includes(school_departments: [:department, :majors]))

        render json: {
          pagy: pagy.vars,
          schools: ActiveModel::Serializer::CollectionSerializer.new(schools, serializer: SchoolSerializer)
        }
      end

      private
        def filter_params
          params.permit(:kind)
        end
    end
  end
end

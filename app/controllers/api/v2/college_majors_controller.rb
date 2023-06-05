# frozen_string_literal: true

module Api
  module V2
    class CollegeMajorsController < ::Api::V2::ApiController
      def index
        pagy, college_majors = pagy(CollegeMajor.includes(:schools))

        render json: {
          pagy: pagy.vars,
          college_majors: ActiveModel::Serializer::CollectionSerializer.new(college_majors, serializer: CollegeMajorSerializer)
        }
      end
    end
  end
end

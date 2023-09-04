# frozen_string_literal: true

module Api
  module V2
    class MajorsController < ::Api::V2::ApiController
      def index
        pagy, majors = pagy(Major.includes(:schools))

        render json: {
          pagy: pagy.vars,
          majors: ActiveModel::Serializer::CollectionSerializer.new(majors, serializer: MajorSerializer)
        }
      end
    end
  end
end

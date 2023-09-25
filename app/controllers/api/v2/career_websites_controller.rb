# frozen_string_literal: true

module Api
  module V2
    class CareerWebsitesController < ::Api::V2::ApiController
      def index
        pagy, career_websites = pagy(CareerWebsite.all)

        render json: {
          pagy: pagy.vars,
          career_websites: ActiveModel::Serializer::CollectionSerializer.new(career_websites, serializer: CareerWebsiteSerializer)
        }
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V2
    class VideosController < ::Api::V2::ApiController
      def index
        pagy, videos = pagy(Video.filter(filter_params).with_deleted)

        render json: {
          pagy: pagy.vars,
          videos: ActiveModel::Serializer::CollectionSerializer.new(videos, serializer: VideoSerializer)
        }
      end

      private
        def filter_params
          params.permit(:updated_at)
        end
    end
  end
end

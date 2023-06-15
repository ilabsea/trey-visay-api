# frozen_string_literal: true

module Api
  module V2
    class VideosController < ::Api::V2::ApiController
      def index
        pagy, videos = pagy(Video.all)

        render json: {
          pagy: pagy.vars,
          videos: ActiveModel::Serializer::CollectionSerializer.new(videos, serializer: VideoSerializer)
        }
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V2
    class JobsController < ::Api::V2::ApiController
      def index
        pagy, jobs = pagy(Job.filter(filter_params).with_deleted.includes(:videos, :job_cluster))

        render json: {
          pagy: pagy.vars,
          jobs: ActiveModel::Serializer::CollectionSerializer.new(jobs, serializer: JobSerializer)
        }
      end

      private
        def filter_params
          params.permit(:updated_at)
        end
    end
  end
end

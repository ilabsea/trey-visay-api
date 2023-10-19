# frozen_string_literal: true

module Api
  module V2
    class JobClustersController < ::Api::V2::ApiController
      def index
        pagy, job_clusters = pagy(JobCluster.filter(filter_params).with_deleted.includes(:videos))

        render json: {
          pagy: pagy.vars,
          job_clusters: ActiveModel::Serializer::CollectionSerializer.new(job_clusters, serializer: JobClusterSerializer)
        }
      end

      private
        def filter_params
          params.permit(:updated_at)
        end
    end
  end
end

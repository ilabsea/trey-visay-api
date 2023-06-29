# frozen_string_literal: true

module Api
  module V2
    class JobsController < ::Api::V2::ApiController
      def index
        pagy, jobs = pagy(Job.includes(:videos, :schools, :job_cluster))

        render json: {
          pagy: pagy.vars,
          jobs: ActiveModel::Serializer::CollectionSerializer.new(jobs, serializer: JobSerializer)
        }
      end
    end
  end
end

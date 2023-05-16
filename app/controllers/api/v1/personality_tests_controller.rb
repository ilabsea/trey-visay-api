# frozen_string_literal: true

module Api
  module V1
    class PersonalityTestsController < ::ApiController
      def create
        user = User.find_by(uuid: params["data"]["user_uuid"])
        return head :forbidden if user.nil?

        personality_test = user.personality_tests.new(personality_test_params)

        if personality_test.save
          render json: personality_test, status: :created
        else
          Log.create(game: params["data"], version: params["data"]["version"])

          render json: personality_test.errors, status: :unprocessable_entity
        end
      end

      private
        def personality_test_params
          params.require(:data).permit(personality_selections_attributes: [:personality_code])
        end
    end
  end
end

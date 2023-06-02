# frozen_string_literal: true

module Api
  module V2
    class UsersController < ::Api::V2::ApiController
      def create
        user = User.new(user_params)

        if user.save
          render json: user, status: :created
        else
          render json: { error: user.errors }, status: :unprocessable_entity
        end
      end

      private
        def user_params
          params.require(:user).permit(
            :full_name, :sex, :date_of_birth, :phone_number, :grade,
            :class_group, :high_school_code, :middle_school_id,
            :commune_code
          )
        end
    end
  end
end

# frozen_string_literal: true

class UsersController < ApplicationController
  helper_method :filter_params

  def index
    respond_to do |format|
      format.html {
        @pagy, @users = pagy(authorize policy_scope(User.filter(filter_params).order(created_at: :desc).includes(:games, :personal_understandings, :high_school)))
      }

      format.xlsx {
        @users = policy_scope(User.filter(filter_params))

        if @users.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to users_url
        else
          @holland_quizzes = HollandQuiz.where(user_id: @users.pluck(:id)).includes(:holland_scores, holland_major_responses: :major, holland_job_responses: :job)
          @intelligence_quizzes = IntelligenceQuiz.where(user_id: @users.pluck(:id)).includes(intelligence_scores: :intelligence_category)

          render xlsx: "index", filename: "users_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }
    end
  end

  def download
    @users = User.filter(params).includes(games: :personal_understandings)

    if @users.length > Settings.max_download_record then
      flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
      redirect_to users_url
    else
      send_data(::AssessmentResultService.new(@users).zip_data, type: "application/zip", filename: "assessment_result.zip")
    end
  end

  def show
    @user = authorize User.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        @questions = SelfUnderstandingQuestion.includes(:options)
        @holland_quizzes = @user.holland_quizzes.includes(:self_understanding_responses, :holland_scores, holland_major_responses: :major, holland_job_responses: :job)
        @intelligence_quizzes = @user.intelligence_quizzes.includes(intelligence_scores: :intelligence_category)

        render pdf: "treyvisay_user_#{@user.full_name}"
      end
    end
  end

  private
    def filter_params
      params.permit(
        :name, :province_id, :district_id, :high_school_code,
        :grade, :gender, :class_group, :start_date, :end_date
      )
    end
end

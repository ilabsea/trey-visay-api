# frozen_string_literal: true

class PersonalityTypesController < ApplicationController
  helper_method :filter_params
  before_action :authorize_personality_type, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html {
        @pagy, @personality_types = pagy(authorize PersonalityType.filter(filter_params))
      }

      format.xlsx {
        @personality_types = authorize PersonalityType.filter(filter_params)

        if @personality_types.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to personality_types_url
        else
          render xlsx: "index", filename: "personality_types_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @personality_types = authorize PersonalityType.filter(filter_params)

        render json: @personality_types
      }
    end
  end

  def new
    @personality_type = authorize PersonalityType.new
  end

  def create
    @personality_type = authorize PersonalityType.new(personality_type_params)

    if @personality_type.save
      redirect_to personality_types_url, notice: I18n.t("shared.create_success", name: I18n.t("sidebar.personality_type"))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @personality_type.update(personality_type_params)
      redirect_to personality_types_url, notice: I18n.t("shared.update_success", name: I18n.t("sidebar.personality_type"))
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @personality_type.destroy

    redirect_to personality_types_url, notice: I18n.t("shared.delete_success", name: I18n.t("sidebar.personality_type"))
  end

  private
    def filter_params
      params.permit(:name)
    end

    def personality_type_params
      params.require(:personality_type).permit(
        :code, :name_en, :name_km, :recommendation, :personal_value, :skill_and_ability, :description

      )
    end

    def authorize_personality_type
      @personality_type = authorize PersonalityType.find(params[:id])
    end
end

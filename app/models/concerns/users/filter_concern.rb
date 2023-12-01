# frozen_string_literal: true

module Users::FilterConcern
  extend ActiveSupport::Concern

  included do
    def self.filter(params = {})
      scope = all
      scope = scope.where("LOWER(full_name) LIKE ?", "%#{params[:name].strip}%") if params[:name].present?
      scope = scope.where(province_id: params[:province_id]) if params[:province_id].present?
      scope = scope.where(district_id: params[:district_id]) if params[:district_id].present?
      scope = scope.where(high_school_code: params[:high_school_code]) if params[:high_school_code].present?
      scope = scope.where(grade: params[:grade]) if params[:grade].present?
      scope = scope.where(sex: params[:gender]) if params[:gender].present?
      scope = scope.where(class_group: params[:class_group]) if params[:class_group].present?
      scope
    end

    def self.find_for_archive(params = {})
      user = find_or_initialize_by(params.slice(:uuid, :full_name))
      user.errors.add(:uuid, I18n.t("user.cannot_be_blank")) if params[:uuid].blank?
      user.errors.add(:full_name, I18n.t("user.cannot_be_blank")) if params[:full_name].blank?
      user
    end
  end
end

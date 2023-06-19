# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def css_id_name
    prefix = params["controller"].downcase.split("/").join("-")
    subfix = params["action"]

    "#{prefix}-#{subfix}"
  end

  def show_tip(subject_code, level)
    SubjectTip.where("subject_code = '#{subject_code}' and tip_type = '#{level}'")
  end

  def css_active_class(controller_name, *other)
    return "active" if params[:controller] == controller_name || other.include?(params[:controller])
  end

  def display_date(date)
    return "" unless date.present?

    format = "YYYY-MM-DD"
    format = format.downcase.split("-").join("_")

    I18n.l(date, format: :"#{format}")
  end

  def display_datetime(date)
    return "" unless date.present?

    format = "YYYY-MM-DD"
    format = format.downcase.split("-").join("_") + "_time"

    I18n.l(date, format: :"#{format}")
  end

  def timeago(date, type = "date")
    return "" unless date.present?

    dis_date = type == "date" ? display_date(date) : display_datetime(date)
    str = "<span class='timeago' data-date='#{dis_date}'>"
    str += time_ago_in_words(date)
    str += "</span>"
    str
  end
end

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
    "active" if params[:controller] == controller_name || other.include?(params[:controller])
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

  def link_to_add_fields(name, f, association, option = {})
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder, option: option)
    end

    link_to(name, "#", class: "add_#{association} btn add_association #{option[:class]}", data: { id: id, fields: fields.gsub("\n", "") })
  end
end

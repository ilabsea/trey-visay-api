# frozen_string_literal: true

module SelfUnderstandingResponsesHelper
  def reponse_value_html(question, value)
    type = question.type.to_s.split("::").last.underscore
    response_type = ["response_value", type, "html"].compact.join("_")

    send(response_type, question, value.to_s) rescue value.to_s
  end

  def response_value_selectone_field_html(question, value)
    option = question.options.select { |opt| opt.value == value }.first

    icon_with_value(option.try(:name) || value)
  end

  def response_value_select_multiple_field_html(question, values)
    values.split(",").map do |value|
      option = question.options.select { |opt| opt.value == value }.first

      icon_with_value(option.try(:name) || value)
    end.join
  end

  def response_value_text_input_field_html(question, value)
    icon_with_value(value)
  end

  private
    def icon_with_value(value)
      return "" unless value.present?

      "<div class='d-flex align-items-center text-primary'>" +
        "<span class='fi-circle-check'>" +
          image_tag("/images/check.png", class: "img-circular-small") +
        "</span>" +
        value +
      "</div>"
    end
end

# frozen_string_literal: true

module MajorsHelper
  def field_value(label, value)
    "<div class='row my-1'>" +
      "<div class='col-4'>"+ label +"</div>" +
      "<div class='col-8'>"+ (value || "N/A") +"</div>" +
    "</div>"
  end

  def school_list_tooltip(major)
    return "" unless major.schools.present?

    tooltip_title = school_list_html(major.schools)
    "<span data-toggle=\"tooltip\" data-placement=\"top\" data-html=\"true\" data-title=\"#{tooltip_title}\">#{major.schools.length}</span>"
  end

  private
    def school_list_html(schools)
      "<ol class='text-left'>" +
      schools.map { |school| "<li>#{school.name}</li>" }.join("") +
      "</ol>"
    end
end

# frozen_string_literal: true

module CollegeMajorsHelper
  def field_value(label, value)
    "<div class='row my-1'>" +
      "<div class='col-4'>"+ label +"</div>" +
      "<div class='col-8'>"+ (value || "N/A") +"</div>" +
    "</div>"
  end
end

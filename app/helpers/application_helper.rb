# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def css_id_name
    prefix = params['controller'].downcase.split('/').join('-')
    subfix = params['action']

    "#{prefix}-#{subfix}"
  end

  def show_tip(subject_code, level)
    SubjectTip.where("subject_code = '#{subject_code}' and tip_type = '#{level}'")
  end
end

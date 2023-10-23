# frozen_string_literal: true

class SchoolImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_type
      "SchoolBatch"
    end

    def redirect_success_url
      schools_url
    end

    def redirect_error_url
      new_school_importer_url
    end

    def itemable_attributes
      [
        :id, :code, :name, :address, :province, :phone_numbers, :emails, :website_or_facebook,
        :kind, :category, :logo_cache, :province_id, :display_order,
        school_departments_attributes: [
          :id, :_destroy,
          department_attributes: [:name],
          school_majors_attributes: [major_attributes: [:name]]
        ]
      ]
    end
end

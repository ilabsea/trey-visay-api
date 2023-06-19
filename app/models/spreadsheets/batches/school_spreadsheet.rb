# frozen_string_literal: true

module Spreadsheets
  module Batches
    class SchoolSpreadsheet
      attr_reader :school

      def initialize(school, rows)
        @school = school
        @rows = rows
        @school_departments_attributes = []
      end

      def process(row, zipfile)
        school.attributes = {
          code: row["school_code"],
          name: row["school_name"],
          address: row["address"],
          province: Pumi::Province.find_by_id(row["province_code"]).try(:name_km),
          phone_numbers: row["tels"],
          emails: row["emails"],
          website_or_facebook: row["website_or_facebook"],
          kind: row["type"],
          category: row["category"],
          logo: get_logo(row["logo"], zipfile)
        }

        set_remove_old_school_department
        set_school_department_and_majors

        school.school_departments_attributes = @school_departments_attributes
        school
      end

      private
        def set_remove_old_school_department
          return if school.new_record?

          school.school_departments.each do |sp|
            @school_departments_attributes.push({ id: sp.id, _destroy: true })
          end
        end

        def set_school_department_and_majors
          school_index = @rows.index { |row| row["school_code"] == school.code }

          return unless school_index.present?

          @school_departments_attributes.concat Spreadsheets::Batches::SchoolMajorSpreadsheet.new(school, @rows[school_index..-1]).process
        end

        def get_logo(filename, zipfile)
          entry = zipfile.select { |ent| ent.name.split("/").last.split(".").first == "#{filename.to_s.split('.').first}" }.first

          open_file(entry, zipfile) if entry.present?
        end

        def open_file(entry, zipfile)
          file_destination = File.join("public/uploads/tmp", entry.name)

          FileUtils.mkdir_p(File.dirname(file_destination))
          zipfile.extract(entry, file_destination) { true }

          Pathname.new(file_destination).open
        end
    end
  end
end

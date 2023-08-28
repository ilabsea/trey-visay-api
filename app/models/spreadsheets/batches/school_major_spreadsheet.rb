# frozen_string_literal: true

module Spreadsheets
  module Batches
    class SchoolMajorSpreadsheet
      attr_reader :school

      def initialize(school, rows)
        @school = school
        @rows = rows
        @current = {}
      end

      def process
        departments = []

        @rows.each_with_index do |row, index|
          break if row_ended?(row, index)

          if row["department_name"].present?
            departments.push(new_department(row))
            next
          end

          append_major(row)
        end

        departments
      end

      private
        def row_ended?(row, index)
          (index == 0 && row["department_name"].blank?) || (index > 0 && row["school_code"].present?)
        end

        def new_department(row)
          @current = {
            department_attributes: { name: row["department_name"], grade: Department.grades[row["grade"]] },
            school_majors_attributes: [{ major_attributes: { name: row["major_name"] } }]
          }
        end

        def append_major(row)
          @current[:school_majors_attributes].push({ major_attributes: { name: row["major_name"] } })
        end
    end
  end
end

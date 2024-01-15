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
            tmp_major_list: [row["major_name"].to_s.strip]
          }
        end

        def append_major(row)
          @current[:tmp_major_list].push(row["major_name"]) if row["major_name"].to_s.strip.present?
        end
    end
  end
end

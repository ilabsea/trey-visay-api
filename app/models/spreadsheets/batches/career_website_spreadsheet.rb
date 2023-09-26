# frozen_string_literal: true

module Spreadsheets
  module Batches
    class CareerWebsiteSpreadsheet
      include ::Spreadsheets::AttachmentSpreadsheet

      attr_reader :career_website

      def initialize(career_website)
        @career_website = career_website
      end

      def process(row, zipfile)
        career_website.attributes = {
          name: row["name"],
          url: row["url"],
          description: row["description"],
          logo: find_attachment(row["logo_name"], zipfile)
        }

        career_website
      end
    end
  end
end

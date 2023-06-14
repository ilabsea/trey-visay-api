# frozen_string_literal: true

module Spreadsheets
  module Batches
    class VideoSpreadsheet
      attr_reader :video

      def initialize(video)
        @video = video
      end

      def process(row)
        video.attributes = {
          code: row["code"],
          name: row["name"],
          url: row["url"],
          author: row["author"]
        }
        video
      end
    end
  end
end

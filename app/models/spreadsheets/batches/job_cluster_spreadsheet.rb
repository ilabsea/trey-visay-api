# frozen_string_literal: true

module Spreadsheets
  module Batches
    class JobClusterSpreadsheet
      include ::Spreadsheets::AttachmentSpreadsheet

      attr_reader :cluster

      def initialize(cluster)
        @cluster = cluster
      end

      def process(row, zipfile)
        cluster.attributes = {
          code: row["code"],
          name: row["name"],
          display_order: row["display_order"],
          recommendation: row["recommendation"],
          logo: find_attachment(row["logo"], zipfile),
          cluster_videos_attributes: cluster_videos_attributes(row)
        }

        cluster
      end

      private
        def cluster_videos_attributes(row)
          videos = Video.where(code: row["video_codes"].to_s.split("\;"))

          cluster_videos = cluster.cluster_videos.map { |cluster_video| { id: cluster_video.id, _destroy: true } }
          cluster_videos.concat videos.map { |video| { video_id: video.id } }
          cluster_videos
        end
    end
  end
end

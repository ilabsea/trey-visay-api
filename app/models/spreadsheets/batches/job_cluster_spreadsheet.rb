# frozen_string_literal: true

module Spreadsheets
  module Batches
    class JobClusterSpreadsheet
      attr_reader :cluster

      def initialize(cluster)
        @cluster = cluster
      end

      def process(row)
        cluster.attributes = {
          code: row["code"],
          name: row["name"],
          display_order: row["display_order"]
        }

        cluster
      end
    end
  end
end

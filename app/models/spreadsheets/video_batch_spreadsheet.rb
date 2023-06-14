# frozen_string_literal: true

module Spreadsheets
  class VideoBatchSpreadsheet < BaseSpreadsheet
    attr_reader :batch

    def initialize
      @batch = ::Batches::VideoBatch.new
      @items = []
    end

    def import(file)
      return unless valid?(file)

      spreadsheet(file).each_with_pagename do |sheet_name, sheet|
        rows = sheet.parse(headers: true)
        @items = rows[1..-1]
      rescue
        Rails.logger.warn "unknown handler for sheet: #{sheet_name}"
      end

      batch.importing_items = importing_items
      batch.attributes = batch.attributes.merge(batch_params(file))
      batch
    end

    private
      def batch_params(file)
        items = batch.importing_items.map(&:itemable)
        {
          total_count: items.length,
          valid_count: items.select(&:valid?).length,
          new_count: items.select(&:new_record?).length,
          reference: file
        }
      end

      def importing_items
        codes = @items.map { |r| r["code"] }
        items = Video.where(code: codes)

        @items.map do |row|
          video = items.select { |f| f.code == row["code"] }.first || Video.new

          batch.importing_items.new(
            itemable: Spreadsheets::Batches::VideoSpreadsheet.new(video).process(row))
        end
      end
  end
end

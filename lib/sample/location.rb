# frozen_string_literal: true

require_relative "base"

module Sample
  class Location < Sample::Base
    def self.export
      export_file("provinces", Pumi::Province.all)
      export_file("districts", Pumi::District.all, "province_id")
      export_file("communes", Pumi::Commune.all, "district_id")
    end

    private_class_method

    def self.export_file(file_name, collection, parent_method = nil)
      contents = []

      collection.each do |record|
        contents.push(
          code: record.id,
          label: record.name_km,
          name_en: record.name_en,
          parent_code: (record.send(parent_method) if parent_method.present?)
        )
      end

      write_to_file(contents, file_name)
    end
  end
end

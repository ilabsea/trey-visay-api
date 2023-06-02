# frozen_string_literal: true

require "csv"

module Sample
  class Base
    def spreadsheet(filename)
      path = File.expand_path(Pathname.new(File.join(Dir.pwd, "db", "csv")) + "#{filename}.xlsx")

      Roo::Spreadsheet.open(path)
    end

    private_class_method

    def self.csv_path
      Pathname.new(File.join(Dir.pwd, "db", "csv"))
    end

    def self.write_to_file(data, filename)
      Dir.mkdir("public/db") unless File.exist?("public/db")
      file_path = Rails.root.join("public", "db", "#{filename}.json")
      content = JSON.pretty_generate(data)

      File.open(file_path, "w") do |f|
        f.puts(content)
      end
    end

    def self.strip_str(str)
      str.to_s.strip.split(";").map(&:strip).join(";")
    end
  end
end

# frozen_string_literal: true

module Spreadsheets::AttachmentSpreadsheet
  def find_attachment(filename, zipfile)
    return unless filename.present?

    entry = zipfile.select { |ent| ent.name.split("/").last.split(".").first == "#{filename.to_s.split('.').first}" }.first

    open_file(entry, zipfile) if entry.present?
  end

  def open_file(entry, zipfile)
    file_destination = File.join("public/uploads/tmp", entry.name)

    FileUtils.mkdir_p(File.dirname(file_destination))
    zipfile.extract(entry, file_destination) { true }

    Pathname.new(file_destination).open
  end

  def format_code(code)
    return code.to_i.to_s if code.kind_of? Float

    code.to_s
  end
end

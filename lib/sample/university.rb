# frozen_string_literal: true

require_relative "base"

module Sample
  class University < Sample::Base
    def self.load(file, options = {})
      path = File.expand_path(csv_path + "#{file}.xlsx")
      xlsx = Roo::Spreadsheet.open(path)

      clean_departments_and_major
      xlsx.each_with_pagename do |name, sheet|
        sheet = sheet.parse(headers: true)
        sheet.each_with_index do |row, index|
          next if index == 0
          assign_school(row, name)
          assign_department(row)
          assign_major(row)
        end
      end

      puts "Loaded #{file.titleize} samples" if options[:verbose]
    end

    def self.export
      schools = []
      School.all.includes(:departments, :department_majors).each do |school|
        skool = {
          id: school.id,
          code: school.code,
          universityName: school.name,
          logoName: school.logo.file&.filename&.split(".")&.first || "",
          address: school.address.to_s.gsub("<U+200B>", ""),
          province: school.province,
          phoneNumbers: school.phone_numbers.to_s.gsub("<U+200B>", "").split(";"),
          faxes: school.faxes.to_s.gsub("<U+200B>", "").split(";"),
          emails: school.emails.to_s.gsub("<U+200B>", "").split(";"),
          websiteOrFacebook: school.website_or_facebook.to_s.gsub("<U+200B>", "").split(";"),
          mailbox: school.mailbox,
          category: school.category,
          departments: school.departments.map do |department|
            { name: department.name.gsub("<U+200B>", ""), majors: department.majors.collect(&:name) }
          end
        }
        schools.push(skool)
      end

      ids = Major.where(department_id: nil).pluck(:school_id).uniq
      School.where(id: ids).includes(:majors).each do |school|
        skool = schools.find { |obj| obj[:id] == school.id }
        skool[:departments].push(name: "", majors: school.majors.pluck(:name))
      end

      write_to_file(schools, "universities")
    end

    private_class_method

    def self.clean_departments_and_major
      Major.destroy_all
      Department.destroy_all
    end

    def self.assign_major(row)
      return if row["major"].blank?

      major = Major.new(name: row["major"], school: @school)
      major.department = @department if @department.present?
      major.save
    end

    def self.assign_department(row)
      return if row["department_name"].blank?

      @department = @school.departments.create(
        name: row["department_name"].split(".").last.strip
      )
    end

    def self.assign_school(row, category_name)
      return if row["name"].blank?

      @department = nil
      @school = ::School.find_or_initialize_by(code: row["code"].strip)
      @school.update_attributes!(
        name: row["name"],
        address: row["address"],
        province: row["province"],
        phone_numbers: strip_str(row["phone_numbers"]),
        faxes: strip_str(row["faxes"]),
        emails: strip_str(row["emails"]),
        website_or_facebook: strip_str(row["website_or_facebook"]),
        mailbox: row["mailbox"],
        category: category_name
      )

      assign_logo(row)
    end

    # upload photo
    # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-%22Upload%22-from-a-local-file
    def self.assign_logo(row)
      return if row["logo_name"].blank?
      logo_image = images.select { |image| image.split("/").last.split(".").first == row["logo_name"] }.first
      return if logo_image.nil?
      @school.logo = Pathname.new(logo_image).open
      @school.save
    end

    def self.images
      @images ||= Dir.glob(Rails.root.join("lib", "assets", "school_logos", "*"))
    end
  end
end

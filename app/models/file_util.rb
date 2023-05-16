# frozen_string_literal: true

class FileUtil
  def self.path_of(filename)
    File.join(csv_dir, filename)
  end

  def self.csv_dir
    File.join(Rails.root, "db", "csv")
  end
end

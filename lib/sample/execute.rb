# frozen_string_literal: true

module Sample
  class Execute
    def self.load(file, options = {})
      path = File.expand_path(samples_path + "#{file}.rb")
      # Check to see if the specified file has been loaded before
      return if $LOADED_FEATURES.include?(path)

      require path
      puts "Loaded #{file.titleize} samples" if options[:verbose]
    end

    private_class_method

    def self.samples_path
      Pathname.new(File.join(File.dirname(__FILE__), "..", "..", "db", "samples"))
    end
  end
end

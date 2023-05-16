# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  strip_attributes

  private
    def secure_id
      self.id ||= SecureRandom.hex(4)

      return unless self.class.exists?(id: id)

      self.id = SecureRandom.hex(4)
      secure_id
    end

    def secure_code
      self.code ||= SecureRandom.uuid[0..5]

      return unless self.class.exists?(code: code)

      self.code = SecureRandom.uuid[0..5]
      secure_code
    end
end

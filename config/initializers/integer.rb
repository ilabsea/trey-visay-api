# frozen_string_literal: true

class Integer
  # Does this string represent an integer?
  def to_khm
    mapping = {
      "0" => "០",
      "1" => "១",
      "2" => "២",
      "3" => "៣",
      "4" => "៤",
      "5" => "៥",
      "6" => "៦",
      "7" => "៧",
      "8" => "៨",
      "9" => "៩"
    }
    value = ""
    self.to_s.split("").each do |ch|
      value = value + mapping[ch]
    end
    value
  end
end

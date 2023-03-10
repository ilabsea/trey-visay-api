# frozen_string_literal: true

module UsersHelper
  def personal_understanding_info(fails_count)
    return "" if fails_count.zero?

    "ធ្លាក់ <span class='dangerous'>#{fails_count}</span>ដង"
  end
end

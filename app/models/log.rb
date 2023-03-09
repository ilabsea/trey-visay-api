# frozen_string_literal: true

# == Schema Information
#
# Table name: logs
#
#  id         :bigint(8)        not null, primary key
#  user       :text(65535)
#  game       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  version    :string(255)
#

class Log < ApplicationRecord
end

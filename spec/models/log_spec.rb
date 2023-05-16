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

require "rails_helper"

RSpec.describe Log, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

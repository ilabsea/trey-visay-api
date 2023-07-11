# frozen_string_literal: true

# == Schema Information
#
# Table name: quizzes
#
#  id          :string(255)      not null, primary key
#  user_id     :integer
#  quizzed_at  :datetime
#  type        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  finished_at :datetime
#
require "rails_helper"

RSpec.describe Quiz, type: :model do
  it { is_expected.to belong_to(:user) }
end

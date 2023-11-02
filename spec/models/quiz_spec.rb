# frozen_string_literal: true

# == Schema Information
#
# Table name: quizzes
#
#  id                       :string(255)      not null, primary key
#  user_id                  :integer
#  quizzed_at               :datetime
#  type                     :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  finished_at              :datetime
#  self_understanding_score :integer
#  display_order            :integer
#
require "rails_helper"

RSpec.describe Quiz, type: :model do
  describe "#before_create, set display_order" do
    let!(:user) { create(:user) }
    let!(:holland_quiz) { create(:holland_quiz, user: user) }
    let!(:holland_quiz2) { create(:holland_quiz, user: user) }
    let!(:intelligence_quiz) { create(:intelligence_quiz, user: user) }

    it "set holland_quiz display_order to 1" do
      expect(holland_quiz.display_order).to eq 1
    end

    it "set holland_quiz2 display_order to 2" do
      expect(holland_quiz2.display_order).to eq 2
    end

    it "set intelligence_quiz display_order to 1" do
      expect(intelligence_quiz.display_order).to eq 1
    end
  end
end

require "rails_helper"

RSpec.describe Users::ScheduleDeletionConcern, type: :model do
  let!(:user) { create(:user) }
  let!(:visit) { create(:visit, user:) }
  let!(:holland_quiz) { create(:holland_quiz, user:) }
  let!(:intelligence_quiz) { create(:intelligence_quiz, user:) }

  describe "#after_destroy, #schedule_real_destroy" do
    before { user.destroy }

    it { expect(user.send(:removing_date)).to eq(user.deleted_at + User::REMOVING_PERIOD.days) }

    it "hides user and keep association" do
      expect(user.visits.present?).to be_truthy
      expect(user.holland_quizzes.present?).to be_truthy
      expect(user.intelligence_quizzes.present?).to be_truthy
    end

    it "add job to real destroy" do
      expect(UserDeletionJob.jobs.count).to eq(1)
    end
  end

  describe "#after_real_destroy, #remove_association" do
    it "deletes user and its association" do
      user.really_destroy!

      expect(user.visits.present?).to be_falsey
      expect(user.holland_quizzes.present?).to be_falsey
      expect(user.intelligence_quizzes.present?).to be_falsey
    end
  end
end

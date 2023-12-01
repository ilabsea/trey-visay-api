# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserDeletionJob, type: :job do
  describe "perfom" do
    let!(:user) { create(:user) }

    it "calls user really_destroy!" do
      subject.perform(user.id)

      expect(User.with_deleted.find_by id: user.id).to be_nil
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe Accounts::GrafanaConcern, type: :model do
  describe "after_create, add_to_dashboard" do
    context "create new account and have confirmed" do
      before {
        allow_any_instance_of(Account).to receive(:unallow_access_dashboard?).and_return(false)
      }

      it "adds a job to AccountJob" do
        expect { create(:account) }.to change(AccountJob.jobs, :count).by(1)
      end

      it "adds the account to dashboard" do
        create(:account)

        expect(AccountJob.jobs.last["args"][0]).to eq("add_to_dashboard")
      end
    end
  end

  describe "#after_update, add_to_dashboard" do
    context "account set to confirmed" do
      let(:account) { create(:account) }

      before {
        account.update(confirmed_at: nil, skip_callback: false)

        allow(account).to receive(:unallow_access_dashboard?).and_return false
      }

      it "adds the account to dashboard" do
        account.update(confirmed_at: Time.now)
        expect(AccountJob.jobs.last["args"][0]).to eq("add_to_dashboard")
      end

      it "adds an job to AccountJob" do
        expect {
          account.update(confirmed_at: Time.now)
        }.to change(AccountJob.jobs, :count)
      end
    end

    context "deactivate account" do
      let!(:account) { create(:account, gf_user_id: 1) }

      before do
        allow(account).to receive(:unallow_access_dashboard?).and_return false
      end

      it "adds a job to AccountJob" do
        expect {
          account.update(actived: false)
        }.to change(AccountJob.jobs, :count)
      end

      it "remove account from the dashboard" do
        account.update(actived: false)

        expect(AccountJob.jobs.last["args"][0]).to eq("remove_from_dashboard")
      end
    end

    context "activate account" do
      let!(:account) { create(:account, actived: false) }

      before do
        allow(account).to receive(:unallow_access_dashboard?).and_return false
      end

      it "adds a job to AccountJob" do
        expect {
          account.update(actived: true)
        }.to change(AccountJob.jobs, :count)
      end

      it "remove account from the dashboard" do
        account.update(actived: true)

        expect(AccountJob.jobs.last["args"][0]).to eq("add_to_dashboard")
      end
    end
  end

  describe "#unallow_access_dashboard?" do
    context "skip_callback is true" do
      let(:account) { build(:account, skip_callback: true) }

      before do
        stub_const("ENV", ENV.to_hash.merge("GF_DASHBOARD_URL" => "http://localhost:8000"))
      end

      it "returns true" do
        expect(account.send("unallow_access_dashboard?")).to be_truthy
      end
    end

    context "environment variable GF_DASHBOARD_URL is blank" do
      let(:account) { build(:account, :allow_callback) }

      before do
        stub_const("ENV", ENV.to_hash.merge("GF_DASHBOARD_URL" => ""))
      end

      it "returns true" do
        expect(account.send("unallow_access_dashboard?")).to be_truthy
      end
    end

    context "allow_callback, has_dashboad_url" do
      let(:account) { build(:account, :allow_callback) }

      before do
        stub_const("ENV", ENV.to_hash.merge("GF_DASHBOARD_URL" => "http://localhost:8000"))
      end

      it "returns false" do
        expect(account.send("unallow_access_dashboard?")).to be_falsey
      end
    end
  end
end

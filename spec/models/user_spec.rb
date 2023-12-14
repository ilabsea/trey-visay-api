# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                          :bigint(8)        not null, primary key
#  uuid                        :string(255)
#  full_name                   :string(255)      not null
#  password                    :string(255)      not null
#  username                    :string(255)      not null
#  sex                         :string(255)
#  date_of_birth               :date
#  phone_number                :string(255)
#  school_name                 :string(255)
#  grade                       :string(255)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  photo                       :string(255)
#  high_school_code            :string(255)
#  province_id                 :string(255)
#  district_id                 :string(255)
#  commune_code                :string(255)
#  class_group                 :integer
#  middle_school_id            :integer
#  device_id                   :string(255)
#  device_type                 :integer
#  device_os                   :integer
#  app_version                 :integer
#  registered_at               :datetime
#  other_grade                 :integer
#  holland_quizzes_count       :integer          default(0)
#  intelligence_quizzes_count  :integer          default(0)
#  is_complete_grade_twelve    :boolean
#  is_self_understanding       :boolean
#  is_selected_major_or_career :boolean
#  potential_drop_off          :boolean
#  deleted_at                  :datetime
#

require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to belong_to(:high_school).optional(true) }
  it { is_expected.to have_many(:games) }
  it { is_expected.to have_many(:personality_tests) }
  it { is_expected.to have_many(:personal_understandings).through(:games) }
  it { is_expected.to validate_inclusion_of(:grade).in_array(%w(9 10 11 12 other)) }

  describe ".find_for_archive" do
    let!(:user1) { create(:user) }

    context "Missing uuid and full_name" do
      it "returns error missing uuid and full_name" do
        user = User.find_for_archive
        expect(user.errors[:uuid]).not_to be_nil
        expect(user.errors[:full_name]).not_to be_nil
      end
    end

    context "Invalid info" do
      it "returns nil" do
        user = User.find_for_archive(uuid: "abc", full_name: "abc")

        expect(user.persisted?).to be_falsey
      end
    end

    context "Valid info" do
      it "returns the user" do
        user = User.find_for_archive(uuid: user1.uuid, full_name: user1.full_name)

        expect(user.persisted?).to be_truthy
      end
    end
  end

  describe "before_create, secure_registered_at" do
    context "having value" do
      let!(:registered_at) { DateTime.yesterday }
      let!(:user) { create(:user, registered_at: registered_at) }

      it "takes the assign value" do
        expect(user.registered_at).to eq(registered_at)
      end
    end

    context "no value" do
      let!(:user) { create(:user, registered_at: nil) }

      it "assigns a new value" do
        expect(user.registered_at).not_to be_nil
      end
    end
  end
end

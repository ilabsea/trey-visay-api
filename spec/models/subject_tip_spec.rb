# == Schema Information
#
# Table name: subject_tips
#
#  id           :bigint(8)        not null, primary key
#  subject_code :string(255)      not null
#  tip          :string(255)      not null
#  tip_type     :string(255)      not null
#

require "rails_helper"

RSpec.describe SubjectTip, type: :model do
  it { is_expected.to validate_presence_of(:subject_code) }
  it { is_expected.to validate_presence_of(:tip) }
  it { is_expected.to validate_presence_of(:tip_type) }

  describe ".scopes" do
    before do
      tip = {
        code: "khmerReading",
        medium_tips: [
          "អានបែបត្រួសៗ ឬលម្អិតទៅតាមប្រភេទសៀវភៅ និងអត្ថបទ។",
          "បង្កើនល្បឿននៃការអាន"
        ],
        poor_tips: [
          "អានព្យញ្ជនៈ និងស្រៈឲ្យចេះចាំស្ទាត់ឡើងវិញ។",
          "អានអត្ថបទ ឬសៀវភៅនិទានខ្លីបែបកំសាន្ត និងរីករាយ។"
        ]
      }

      tip[:medium_tips].each do |mt|
        SubjectTip.create(subject_code: tip[:code], tip: mt, tip_type: "medium")
      end

      tip[:poor_tips].each do |pt|
        SubjectTip.create(subject_code: tip[:code], tip: pt, tip_type: "poor")
      end
    end

    it ".mediums" do
      expect(SubjectTip.mediums.pluck(:tip)).to eq ["អានបែបត្រួសៗ ឬលម្អិតទៅតាមប្រភេទសៀវភៅ និងអត្ថបទ។", "បង្កើនល្បឿននៃការអាន"]
    end

    it ".poors" do
      expect(SubjectTip.poors.pluck(:tip)).to eq ["អានព្យញ្ជនៈ និងស្រៈឲ្យចេះចាំស្ទាត់ឡើងវិញ។", "អានអត្ថបទ ឬសៀវភៅនិទានខ្លីបែបកំសាន្ត និងរីករាយ។"]
    end

    it ".subject_by" do
      expect(SubjectTip.subject_by("khmerReading").count).to eq 4
    end
  end
end

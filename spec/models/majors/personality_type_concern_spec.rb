# frozen_string_literal: true

require "rails_helper"

RSpec.describe Majors::PersonalityTypeConcern, type: :model do
  describe "#after_create" do
    before {
      %w(R A I C S E).each do |code|
        create(:personality_type, code: code)
      end
    }

    context "has personality_type" do
      it "creates major_personality_types" do
        major = create(:major, personality_type: "ESA")
        expect(major.personality_types.pluck(:code)).to eq(%w(E S A))
      end
    end

    context "no personality_type" do
      it "doesn't create personality_type" do
        major = create(:major, personality_type: "")
        expect(major.personality_types.length).to eq(0)
      end
    end
  end

  describe "#after_update" do
    before {
      %w(R A I C S E).each do |code|
        create(:personality_type, code: code)
      end
    }

    let(:major) { create(:major, personality_type: "ASC") }

    context "update personality_type" do
      it "create major_personality_types" do
        major.update(personality_type: "ESC")
        expect(major.personality_types.pluck(:code)).to eq(%w(E S C))
      end
    end

    context "update other attribute" do
      it "doesn't create major_personality_types" do
        major.update(name: "test")

        expect(major.personality_types.pluck(:code)).to eq(%w(A S C))
      end
    end
  end
end

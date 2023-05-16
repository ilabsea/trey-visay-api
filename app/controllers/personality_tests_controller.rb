# frozen_string_literal: true

class PersonalityTestsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @test = PersonalityTest.find(params[:id])
    categories = Personality.joins(:personality_selections).where("personality_selections.personality_test_id = ?", params[:id]).group(:category).count
    @categories = Personality.pluck(:category).uniq.map do |cat|
      { name: cat, count: categories[cat].to_i }
    end
  end
end

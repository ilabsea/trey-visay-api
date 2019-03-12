# frozen_string_literal: true

class PersonalityTestsController < ApplicationController
  before_action :authenticate_account!

  def index
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @test = PersonalityTest.find(params[:id])
    @personalities = Personality.joins(:personality_selections).where('personality_selections.personality_test_id = ?', params[:id]).group(:category).count
  end
end

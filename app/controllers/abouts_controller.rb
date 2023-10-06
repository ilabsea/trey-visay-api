# frozen_string_literal: true

class AboutsController < ApplicationController
  skip_before_action :authenticate_account!
  layout :set_layout

  def show
  end

  def terms_and_conditions
  end

  def privacy_policy
  end

  private
    def set_layout
      signed_in? ? "layouts/application" : "layouts/sidebar_less"
    end
end

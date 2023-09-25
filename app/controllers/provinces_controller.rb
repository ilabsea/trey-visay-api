# frozen_string_literal: true

class ProvincesController < ApplicationController
  def index
    provinces = ProvincePolicy::Scope.new(current_account, Pumi::Province).resolve

    render json: provinces
  end
end

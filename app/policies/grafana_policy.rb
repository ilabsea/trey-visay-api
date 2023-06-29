# frozen_string_literal: true

class GrafanaPolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def show?
    ENV["GF_DASHBOARD_URL"].present? && (user.primary_admin? || user.admin?)
  end
end

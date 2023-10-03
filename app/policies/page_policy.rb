# frozen_string_literal: true

class PagePolicy < ApplicationPolicy
  def index?
    user.primary_admin?
  end

  def show?
    index?
  end

  def create?
    false
  end

  def update?
    user.primary_admin?
  end

  def destroy?
    create? && record.visits_count.zero?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end

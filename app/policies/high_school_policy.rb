# frozen_string_literal: true

class HighSchoolPolicy < ApplicationPolicy
  def index?
    user.primary_admin? || user.admin? || user.trainer?
  end

  def show?
    create?
  end

  def create?
    user.primary_admin? || user.admin?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  # NOTE: Be explicit about which records you allow access to!
  class Scope < Scope
    def resolve
      return scope.all if user.primary_admin?

      scope.where.not(version: 1)
    end
  end
end

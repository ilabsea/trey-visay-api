# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    false
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      return scope.all if user.primary_admin? || user.admin?
      return scope.where(province_id: user.province_ids) if user.trainer?
      return scope.where(grade: "other") if user.in_school_other?

      scope.where(high_school_code: user.high_school_ids)
    end
  end
end

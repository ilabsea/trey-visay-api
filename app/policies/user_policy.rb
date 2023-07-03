# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if user.primary_admin? || user.admin?

      scope.where(high_school_code: user.high_school_ids)
    end
  end
end

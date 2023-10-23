# frozen_string_literal: true

class JobClusterPolicy < ApplicationPolicy
  def index?
    update?
  end

  def create?
    user.primary_admin?
  end

  def update?
    user.primary_admin? || user.admin?
  end

  def destroy?
    create?
  end

  # NOTE: Be explicit about which records you allow access to!
  # class Scope < Scope
  #   def resolve
  #     scope.all
  #   end
  # end
end

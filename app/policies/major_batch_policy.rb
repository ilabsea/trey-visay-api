# frozen_string_literal: true

class MajorBatchPolicy < ApplicationPolicy
  def index?
    create?
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
  # class Scope < Scope
  #   def resolve
  #     scope.all
  #   end
  # end
end

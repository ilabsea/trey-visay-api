# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
  def index?
    user.primary_admin? || user.admin?
  end

  def show?
    user.primary_admin? || user.admin?
  end

  def create?
    user.primary_admin? || user.admin?
  end

  def update?
    create?
  end

  def archive?
    return false if record.id == user.id

    create?
  end

  def restore?
    record.deleted?
  end

  def destroy?
    archive? && record.deleted?
  end

  def unlock_access?
    update?
  end

  def resend_confirmation?
    update?
  end

  def enable_dashboard?
    create? && record.confirmed? && record.gf_user_id.blank?
  end

  def disable_dashboard?
    create? && record.confirmed? && record.gf_user_id.present?
  end

  def roles
    return Account::ROLES if user.primary_admin?

    Account::ROLES[1..-1]
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      return scope.all if user.primary_admin?

      scope.where.not(role: :primary_admin)
    end
  end
end

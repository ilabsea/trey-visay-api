# frozen_string_literal: true

class ProvincePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if user.primary_admin? || user.admin?

      scope.all.select { |p| user.province_ids.include? p.id } if user.trainer?
    end
  end
end

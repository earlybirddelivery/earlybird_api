class PosterPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    %i[display_pic]
  end

  def index?
    user.roles.present?
  end

  def update?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end
end

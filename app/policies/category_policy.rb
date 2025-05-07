class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    %i[id name priority display_pic]
  end

  def create?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end

  def index?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def update?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end

  def show?
    index?
  end

  def destroy?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end
end

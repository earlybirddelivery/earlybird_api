class DeliveryBoyPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope.all
  #   end
  # end

  def permitted_attributes
    %i[first_name last_name mobile_number date_of_birth email display_pic]
  end

  def create?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end

  def index?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end

  def update?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end

  def show?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def destroy?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end
end

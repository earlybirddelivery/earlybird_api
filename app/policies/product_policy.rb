class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    [
      :id, :name, :active, :brand_id, :priority, :display_pic, :description, :subscribable,
      { product_variants_attributes: %i[id variant_type quantity price discount default active out_of_stock stock _destroy] }
    ]
  end

  def create?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end

  def explore?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def index?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
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

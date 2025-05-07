class UserFavouriteProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    [:favourite_product_id]
  end

  def create?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def index?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def remove_from_favourites?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end
end

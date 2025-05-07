class CartItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    [
      :id, :product_id, :product_variant_id, :product_variant_version_id, :count, :cart_item_type, :subscriber_id,
      :quantity_per_day, :total_quantity, :subscription_start_date, :subscription_end_date, :subscription_type, :trail_days,
      :trail_pack,
      {
        week_pattern_attributes: %i[id monday tuesday wednesday thursday friday saturday sunday _destroy],
        day_pattern_attributes: %i[id days_gap _destroy],
        quantity_pattern_attributes: %i[id day1_quantity day2_quantity day3_quantity day4_quantity _destroy]
      }
    ]
  end

  def create?
    user.super_admin? || record.customer.user.id == user.id
  end

  def update?
    user.super_admin? || record.cart.customer.user.id == user.id
  end

  def index?
    user.super_admin? || record.customer.user.id == user.id
  end

  def destroy?
    user.super_admin? || record.cart.customer.user.id == user.id
  end
end

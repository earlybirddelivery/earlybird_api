class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    [
      :id, :area, :delivery_boy_id, :address_detail_id, :payment_method, :packed, :delivery_date, :order_type, :payment_notes, :amount_paid_offline,
      {
        order_items_attributes: [
          :id, :product_id, :product_variant_id, :product_variant_version_id, :count, :quantity_per_day, :total_quantity, :subscription_start_date, 
          :subscription_end_date, :subscription_type, :trail_pack, :trail_days,
          {
            week_pattern_attributes: %i[monday tuesday wednesday thursday friday saturday sunday],
            day_pattern_attributes: [:days_gap],
            quantity_pattern_attributes: %i[
              day1_quantity day2_quantity day3_quantity
              day4_quantity
            ]
          }
        ]
      },
      { order_review_attributes: %i[rating comment] }
    ]
  end

  def create?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def index?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def generate_razor_pay_order_id?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def place_order?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def proceed_to_pay?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def out_for_delivery?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end

  def delivered?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end

  def update?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def payment_confirmation?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def show?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def destroy?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end

  def cancel?
    user.id == @record.customer.user.id || user.super_admin?
  end

  def raise_issue?
    user.id == @record.customer.user.id || user.super_admin?
  end
end

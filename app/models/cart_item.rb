class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product, optional: true
  belongs_to :product_variant, optional: true
  belongs_to :product_variant_version, optional: true
  belongs_to :subscriber, class_name: 'User',
                          inverse_of: :subscriptions, optional: true

  has_one :week_pattern, as: :selector, dependent: :destroy
  has_one :day_pattern, as: :selector, dependent: :destroy
  has_one :quantity_pattern, as: :selector, dependent: :destroy

  accepts_nested_attributes_for :week_pattern, allow_destroy: true
  accepts_nested_attributes_for :day_pattern, allow_destroy: true
  accepts_nested_attributes_for :quantity_pattern, allow_destroy: true

  before_save :populate_price

  def self.filter(params)
    CartItem.where(cart_id: params[:cart_id], cart_item_type: params[:cart_item_type] || 'One Time Delivery')
  end

  private

  def populate_price
    self.price = product_variant.final_price
    case cart_item_type
    when Order::ONE_TIME_DELIVERY
      self.cost = product_variant.final_price * count
    when Order::SUBSCRIPTION
      self.cost = price * total_quantity
    end
  end
end

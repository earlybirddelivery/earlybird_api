class OrderItem < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :product_variant, optional: true
  belongs_to :product_variant_version, optional: true
  before_validation :populate_price
  belongs_to :order
  belongs_to :subscriber, class_name: 'User',
                          inverse_of: :subscriptions, optional: true
  delegate :order_type, to: :order

  has_one :week_pattern, as: :selector, dependent: :destroy
  has_one :day_pattern, as: :selector, dependent: :destroy
  has_one :quantity_pattern, as: :selector, dependent: :destroy

  accepts_nested_attributes_for :week_pattern, allow_destroy: true
  accepts_nested_attributes_for :day_pattern, allow_destroy: true
  accepts_nested_attributes_for :quantity_pattern, allow_destroy: true

  def next_delivery_date
    Time.zone.today + 1
  end

  private

  def populate_price
    self.price = product_variant.final_price
    case order_type
    when Order::ONE_TIME_DELIVERY
      self.cost = product_variant.final_price * count
    when Order::SUBSCRIPTION
      self.cost = price * total_quantity
    end
  end
end

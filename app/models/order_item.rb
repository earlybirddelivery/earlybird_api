class OrderItem < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :product_variant, optional: true
  belongs_to :product_variant_version, optional: true
  before_validation :populate_price_and_total_quantity
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

  def populate_price_and_total_quantity
    self.price = product_variant.final_price

    # Calculate total_quantity based on pattern type, order start_date and end_date
    self.total_quantity = calculate_total_quantity

    case order_type
    when Order::ONE_TIME_DELIVERY
      self.cost = product_variant.final_price * (count || 1)
    when Order::SUBSCRIPTION
      self.cost = price * (total_quantity || 0)
    end
  end

  def calculate_total_quantity
    return count if order_type == Order::ONE_TIME_DELIVERY
    return 0 unless subscription_start_date && subscription_end_date

    s_date = subscription_start_date
    e_date = subscription_end_date

    if week_pattern.present?
      # Use week_days array if present, else fallback to boolean columns
      weekdays = if week_pattern.week_days.present?
        week_pattern.week_days
      else
        %w[monday tuesday wednesday thursday friday saturday sunday].select { |day| week_pattern.send(day) }
      end
      weekdays.map!(&:downcase)
      (s_date..e_date).count { |date| weekdays.include?(date.strftime('%A').downcase) }
    elsif day_pattern.present?
      # Deliver every N days (gap between deliveries)
      gap = day_pattern.days_gap.to_i # column is days_gap
      total_days = (e_date - s_date).to_i + 1
      deliveries = 0
      current_day = 0
      while current_day < total_days
        deliveries += 1
        current_day += (gap + 1) # gap days between deliveries means next delivery is after gap+1 days
      end
      deliveries
    elsif quantity_pattern.present?
      # Use day1_quantity, day2_quantity, day3_quantity, day4_quantity
      pattern = [
        quantity_pattern.day1_quantity || 0,
        quantity_pattern.day2_quantity || 0,
        quantity_pattern.day3_quantity || 0,
        quantity_pattern.day4_quantity || 0
      ]
      total_days = (e_date - s_date).to_i + 1
      total_quantity = 0
      total_days.times do |i|
        qty = pattern[i % pattern.length] || 0
        total_quantity += qty
      end
      total_quantity
    else
      count || 0
    end
  end
end

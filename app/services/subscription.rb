# This file consists of post subscription order process
class Subscription
  def initialize(order_id)
    @order = Order.find(order_id)
    @order_items = @order.order_items
    @child_orders = []
    @order_items_by_date = {}
  end

  def generate_deliverable_orders
    @order_items.each do |order_item|
      send("genreate_#{order_item.subscription_type}_order_items", order_item)
    end
    generate_child_orders
  end

  def generate_week_pattern_order_items(order_item)
    order_item_delivery_dates = Calendar.where('date >= ? and date <= ? and day_of_week in (?)', order_item.subscription_start_date,
                                               order_item.subscription_end_date, order_item.week_pattern.week_days).pluck(:date)
    order_item_delivery_dates.each do |date|
      map_order_item_to_date(date, order_item)
    end
  end

  def generate_quantity_pattern_order_items(order_item)
    order_item_delivery_dates = Calendar.where('date >= ? and date <= ?', order_item.subscription_start_date,
                                               order_item.subscription_end_date).pluck(:date)
    quantity_pattern = order_item.quantity_pattern
    selected_pattern = [quantity_pattern.day1_quantity, quantity_pattern.day2_quantity, quantity_pattern.day3_quantity,
                        quantity_pattern.day4_quantity].compact
    pattern_length = selected_pattern.size

    order_item_delivery_dates.each_with_index do |date, index|
      count = selected_pattern[index % pattern_length]
      map_order_item_to_date(date, order_item, count)
    end
  end

  def generate_day_pattern_order_items(order_item)
    gap = order_item.day_pattern.days_gap
    start_date = order_item.subscription_start_date
    end_date = order_item.subscription_end_date
    date = start_date
    loop do
      map_order_item_to_date(date, order_item)
      date += (gap + 1).days
      break if date > end_date
    end
  end

  def map_order_item_to_date(date, parent_order_item, count = nil)
    @order_items_by_date[date] ||= []
    item_count = count || parent_order_item.quantity_per_day
    @order_items_by_date[date] << OrderItem.new(product_id: parent_order_item.product_id,
                                                product_variant_id: parent_order_item.product_variant_id,
                                                count: item_count,
                                                product_variant_version_id: parent_order_item.product_variant_version_id,
                                                cost: item_count * parent_order_item.price,
                                                quantity_per_day: nil)
  end

  def generate_child_orders
    @order_items_by_date.each do |date, order_items|
      @child_orders << Order.new(delivery_date: date, order_items_attributes: order_items)
    end
    orders = Order.import(@child_orders)
  end

end

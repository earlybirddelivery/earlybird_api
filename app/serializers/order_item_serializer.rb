class OrderItemSerializer < ActiveModel::Serializer
  attributes :cost, :count, :quantity_per_day, :total_quantity, :subscription_start_date, :subscription_end_date,
             :subscription_type, :id, :pause_until, :trail_days, :trail_pack, :delivered_count, :next_delivery_date
  belongs_to :product, serializer: ProductSimpleSerializer
  belongs_to :product_variant, serializer: ProductVariantSimpleSerializer
  has_one :week_pattern
  has_one :day_pattern
  has_one :quantity_pattern
end

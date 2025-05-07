class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :price, :count, :cost, :quantity_per_day, :cart_item_type, :total_quantity, :subscription_start_date,
             :subscription_end_date, :subscription_type, :trail_pack, :trail_days
  belongs_to :product
  belongs_to :product_variant
  belongs_to :product_variant_version
  has_one :week_pattern
  has_one :day_pattern
  has_one :quantity_pattern
end

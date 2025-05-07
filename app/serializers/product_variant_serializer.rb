class ProductVariantSerializer < ActiveModel::Serializer
  attributes :id, :variant_type, :price, :discount, :final_price, :default, :quantity,
             :current_product_variant_version_id, :active, :out_of_stock, :stock
end

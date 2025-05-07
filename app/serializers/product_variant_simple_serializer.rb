class ProductVariantSimpleSerializer < ActiveModel::Serializer
  attributes :id, :variant_type, :price, :discount, :final_price, :quantity
end

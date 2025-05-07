class OrderItemBasicSerializer < ActiveModel::Serializer
  attributes :cost, :count, :id
  belongs_to :product, serializer: ProductBasicSerializer
  belongs_to :product_variant, serializer: ProductVariantSimpleSerializer
end

class ProductVariantExploreSerializer < ActiveModel::Serializer
  attributes :id, :variant_type, :final_price, :default, :quantity, :current_product_variant_version_id
end

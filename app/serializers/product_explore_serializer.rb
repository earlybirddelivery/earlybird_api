class ProductExploreSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :product_variants, serializer: ProductVariantExploreSerializer
  belongs_to :brand, serializer: BrandExploreSerializer
end

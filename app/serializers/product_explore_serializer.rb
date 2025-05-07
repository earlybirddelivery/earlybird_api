class ProductExploreSerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :brand, serializer: BrandExploreSerializer
end

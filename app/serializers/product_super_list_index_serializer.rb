class ProductSuperListIndexSerializer < ActiveModel::Serializer
  attributes :id, :name, :display_pic_url, :best_selling, :in_exclusive_offer, :coming_soon, :out_of_stock,
             :subscribable, :active, :priority, :available_as_trail_pack, :available_for_one_time_delivery
  belongs_to :brand, serializer: BrandExploreSerializer

  def ordered_product_variants
    object.product_variants
  end
end

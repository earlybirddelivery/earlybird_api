class ProductSimpleSerializer < ActiveModel::Serializer
  attributes :id, :name, :display_pic_url, :favourite_product, :best_selling, :in_exclusive_offer, :coming_soon, :out_of_stock,
             :subscribable, :description, :available_as_trail_pack, :available_for_one_time_delivery
end

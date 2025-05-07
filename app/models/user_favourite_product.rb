class UserFavouriteProduct < ApplicationRecord
  belongs_to :user
  belongs_to :favourite_product, class_name: 'Product',
                                 inverse_of: :user_favourite_products
end

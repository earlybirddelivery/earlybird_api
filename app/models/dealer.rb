class Dealer < ApplicationRecord
  has_one :address_detail, as: :addressable, dependent: :destroy
end

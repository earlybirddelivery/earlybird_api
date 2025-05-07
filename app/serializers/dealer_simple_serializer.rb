class DealerSimpleSerializer < ActiveModel::Serializer
  attributes :id, :name, :area
  has_one :address_detail
end

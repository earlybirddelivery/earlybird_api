class ProductBasicSerializer < ActiveModel::Serializer
  attributes :id, :name, :subscribable, :description
end

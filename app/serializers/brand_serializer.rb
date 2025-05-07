class BrandSerializer < ActiveModel::Serializer
  attributes :id, :name, :display_pic_url, :category_type, :discount, :description, :active
end

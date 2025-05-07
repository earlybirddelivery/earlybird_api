class CustomerBasicSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name
end

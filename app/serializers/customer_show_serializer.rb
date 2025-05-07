class CustomerShowSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :mobile_number, :email, :display_pic_url, :date_of_birth
  has_one :address_detail
end

class UserSerializer < ActiveModel::Serializer
  attributes :id, :roles, :mobile_number, :email, :cart_id, :referal_code
  belongs_to :customer
  belongs_to :delivery_boy

  def cart_id
    object.customer&.cart&.id
  end
end

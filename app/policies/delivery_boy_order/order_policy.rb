module DeliveryBoyOrder
  class OrderPolicy < ApplicationPolicy
    def update?
      user.roles & [ReferenceDatum::KEY_SUPER_ADMIN, ReferenceDatum::KEY_ADMIN, ReferenceDatum::KEY_DELIVERY_BOY]
    end
  end
end

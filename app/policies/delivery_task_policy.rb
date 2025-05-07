class DeliveryTaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if (user.roles & ReferenceDatum::KEY_ADMIN_ACCESS).any?
        scope.all
      else
        scope.where(delivery_boy_id: user.delivery_boy_id)
      end
    end
  end

  def index?
    (user.roles & [ReferenceDatum::KEY_DELIVERY_BOY]).any?
  end

  def update?
    (user.roles & [ReferenceDatum::KEY_DELIVERY_BOY]).any?
  end
end

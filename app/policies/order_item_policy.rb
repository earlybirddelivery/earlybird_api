class OrderItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    %i[id pause_until]
  end

  def pause_subscription?
    created_user_access
  end

  def resume_subscription?
    created_user_access
  end

  def created_user_access
    user.id == @record.order.customer.user.id || user.super_admin?
  end
end

class ReferralPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    %i[id referal_code referrer_id referred_user_id]
  end

  def create?
    customer_access
  end
end

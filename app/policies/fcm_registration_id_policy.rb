class FcmRegistrationIdPolicy < ApplicationPolicy
  def permitted_attributes
    %i[user_id registration_id device_name]
  end

  def create?
    customer_access
  end
end

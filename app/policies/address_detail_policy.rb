class AddressDetailPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    [
      :id, :full_name, :door_no, :mobile_number, :delivery_line_1, :delivery_line_2, :area, :city, :district, :state, :pincode,
      :land_mark, :address_type, :addressable_type, :addressable_id, :primary,
      { location_attributes: %i[id latitude longitude] }
    ]
  end

  def create?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) }
  end

  def update?
    user.super_admin? || record.addressable.user.id == user.id
  end

  def index?
    user.roles.any? { |role| ReferenceDatum::KEY_CUSTOMER_ACCESS.include?(role) } || user.crm?
  end

  def destroy?
    user.super_admin? || record.addressable.user.id == user.id
  end
end

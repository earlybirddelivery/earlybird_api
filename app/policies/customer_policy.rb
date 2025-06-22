class CustomerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    [
      :first_name,
      :last_name,
      :mobile_number,
      :date_of_birth,
      :email,
      :display_pic,
      {
        address_details_attributes: [
          :full_name,
          :door_no,
          :mobile_number,
          :delivery_line_1,
          :delivery_line_2,
          :area,
          :city,
          :district,
          :state,
          :pincode,
          :address_type,
          :land_mark,
          {
            location_attributes: [:latitude, :longitude]
          }
        ]
      }
    ]
  end

  def search?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) } || user.crm?
  end
  
  def index?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) } || user.crm?
  end

  def update?
    show?
  end

  def show?
    record.user.id == user.id || user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) } || user.crm?
  end

  def destroy?
    user.roles.any? { |role| ReferenceDatum::KEY_ADMIN_ACCESS.include?(role) }
  end
end

module V1
  class BaseController < ApplicationController
    DEFAULT_PER_PAGE = 100
    def per_page
      params[:per_page] || DEFAULT_PER_PAGE
    end

    def set_user_roles
      roles = current_user.roles
      @user_roles = {
        is_customer: roles.include?(ReferenceDatum::KEY_CUSTOMER),
        is_delivery_boy: roles.include?(ReferenceDatum::KEY_DELIVERY_BOY),
        is_admin: (roles & ReferenceDatum::KEY_ADMIN_ACCESS).present?
      }
    end
  end
end

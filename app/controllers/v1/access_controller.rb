module V1
  class AccessController < V1::BaseController
    before_action :doorkeeper_authorize!
    before_action :set_userstamp

    def super_list_access
      (current_user.roles & ReferenceDatum::PRODUCT_SUPER_LIST_ACCESS).any?
    end

    private

    def set_userstamp
      User.current_user = current_user unless Rails.env.test?
    end

    def current_user
      @current_user ||= User.find(doorkeeper_token[:resource_owner_id]) if doorkeeper_token
    end
  end
end

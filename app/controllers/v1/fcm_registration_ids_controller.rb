module V1
  class FcmRegistrationIdsController < AccessController
    def create
      authorize(FcmRegistrationId)
      fcm_registration_id = user.fcm_registration_ids.create!(fcm_registartion_id_params)
      render(json: { message: 'Registration Key Added' }, status: :created)
    end

    private

    def user
      @_user ||= User.find(params[:user_id])
    end

    def fcm_registartion_id_params
      permitted_attributes(FcmRegistrationId)
    end
  end
end

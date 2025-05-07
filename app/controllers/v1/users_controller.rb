module V1
  class UsersController < V1::AccessController
    skip_before_action :doorkeeper_authorize!, only: [:send_verification_otp]

    def send_verification_otp
      user = User.find_by(mobile_number: params[:mobile_number])
      if user.present?
        user.send_otp
        render(json: { message: 'Otp Sent to your mobile number' }, status: :ok)
      else
        render(json: { message: 'User Not found' }, status: :not_found)
      end
    end

    def dashboard
      authorize(User)
      @tiles = RoleDashboardTile.includes(:dashboard_tile).where(role: current_user.roles)
      render(json: @tiles,
             each_serializer: RoleDashboardTileSerializer,
             scope: current_user,
             status: :ok,
             include: '**')
    end
  end
end

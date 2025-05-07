module V1
  class OtpsController < DeviseController
    def send_otp
      user = User.find_by(mobile_number: params[:mobile_number])
      user.send_otp if user.present?
      render(status: :ok)
    end
  end
end

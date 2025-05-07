module Authentication
  class Login
    def initialize(params)
      @params = params
    end

    def validate
      if @params[:login_otp]
        otp_authentication
      elsif @params[:password]
        password_authentication
      elsif @params[:reset_otp]
        password_reset
      end
    end

    private

    def otp_authentication
      user, valid_code = User.confirm_otp(@params[:login_otp], @params[:mobile_number])
      user.confirm_user if valid_code
      [user, valid_code]
    end

    def password_authentication
      authenticated = false
      identifier = @params[:mobile_number] || @params[:email]
      if identifier.present?
        user = if identifier.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
                 User.find_for_database_authentication(email: identifier)
               else
                 User.find_for_database_authentication(mobile_number: identifier)
               end
      end
      authenticated = user&.valid_password?(@params[:password]) if user&.confirmed
      [user, authenticated]
    end

    def password_reset
      user, valid_otp = User.confirm_otp(@params[:reset_otp], @params[:mobile_number])
      user.update!(password: @params[:new_password]) if valid_otp
      [user, valid_otp]
    end
  end
end

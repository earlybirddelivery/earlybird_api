module V1
  class ReferralsController < AccessController
    def create
      authorize(Referral)
      remove_existing_referral
      Referral.create!(referral_params)
      head(:no_content)
    end

    def referred_count
      render(json: { count: current_user.referrals.count }, status: :ok)
    end

    private

    def remove_existing_referral
      current_user.referral&.destroy!
    end

    def referral_params
      params[:referral][:referred_user_id] = current_user.id
      params[:referral][:referrer_id] = User.find_by(referal_code: params[:referral][:referal_code]).id
      permitted_attributes(Referral)
    end
  end
end

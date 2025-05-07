class DeliveryBoy < ApplicationRecord
  has_one_attached :display_pic, dependent: :destroy
  has_one :user
  after_save :setup_user

  def display_pic_url
    return unless display_pic.attached?

    display_pic.url
  end

  def create_user(params)
    user = User.create!(email: email, mobile_number: mobile_number, password: params[:password], delivery_boy_id: id)
    user.user_roles.create!(role: ReferenceDatum::KEY_DELIVERY_BOY)
  end

  private

  def setup_user
    if user
      user.update(email: email) if email_previously_changed?
      user.update(mobile_number: mobile_number) if mobile_number_previously_changed?
      nil
    end
  end
end

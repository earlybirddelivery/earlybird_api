class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :add_referal_code

  has_many :access_grants, class_name: 'Doorkeeper::AccessGrant', foreign_key: :resource_owner_id,
                           dependent: :delete_all
  has_many :access_tokens, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id,
                           dependent: :delete_all
  has_many :user_roles, dependent: :destroy
  has_many :user_favourite_products, dependent: :destroy
  has_many :favourite_products, through: :user_favourite_products
  belongs_to :customer, optional: true
  has_many :subscriptions, foreign_key: :subscriber_id, class_name: 'CartItem'
  has_many :fcm_registration_ids, dependent: :destroy
  has_one :referral, foreign_key: :referred_user_id
  has_many :referrals, foreign_key: :referrer_id, dependent: :restrict_with_exception, class_name: 'Referral'
  has_many :crm_customer_mappings, foreign_key: :crm_id, class_name: 'CrmCustomerMapping'
  has_many :customers, through: :crm_customer_mappings

  belongs_to :delivery_boy, optional: true
  cattr_accessor :current_user

  def send_otp
    otp = rand(1_111..9_999)
    final_otp, trigger_msg = case Rails.env
                             when 'production'
                               [otp, true]
                             when 'staging'
                               ENV['TEST_NUMBERS'].include?(mobile_number) ? [otp, true] : [1234, false]
                             else
                               [1234, false]
                             end
    update!(otp: final_otp, otp_expiry_time: Time.zone.now + 5.minutes)
    SpringEdge::Messages.send_otp(otp, mobile_number) if trigger_msg
  end

  # The currect user instance have to be thread safe as this value will be available accross all calls even if not authenticated.
  # For reference thread safety portion of this link - https://github.com/infused/blamer
  def self.current_user
    Thread.current[:current_user]
  end

  def self.confirm_otp(otp, mobile_number)
    user = User.where('otp = ? and mobile_number = ? and otp_expiry_time > ?', otp, mobile_number, Time.zone.now).first
    if user.present?
      user.update!(otp: nil, otp_expiry_time: nil)
      [user, true]
    else
      [user, false]
    end
  end

  def confirm_user
    update!(confirmed: true)
  end

  def setup_notification_key(registration_id)
    if notification_key
      Firebase::Setup.update_notification_key(notification_key_name, notification_key, [registration_id])
    else
      key = "#{first_name}_#{id}"
      update!(notification_key_name: key) unless notification_key
      firbase = Firebase::Setup.generate_notification_key(key, [registration_id])
    end
  end

  def customers_count
    if crm?
      CrmCustomerMapping.where(crm_id: id).count
    elsif admin? || super_admin?
      Customer.count
    end
    0
  end

  def orders_count
    if crm?
      Order.where(crm_id: id).count
    elsif admin? || super_admin?
      Order.count
    end
    0
  end

  def carts_count
    if crm?
      Cart.where(created_by: id).count
    elsif admin? || super_admin?
      Cart.count
    end
    0
  end

  def super_admin?
    roles.include?(ReferenceDatum::KEY_SUPER_ADMIN)
  end

  def delivery_boy?
    roles.include?(ReferenceDatum::KEY_DELIVERY_BOY)
  end

  def crm?
    roles.include?(ReferenceDatum::KEY_CRM)
  end

  def customer?
    roles.include?(ReferenceDatum::KEY_CUSTOMER)
  end

  def admin?
    roles.include?(ReferenceDatum::KEY_ADMIN)
  end

  def self.current_user=(user)
    Thread.current[:current_user] = user
  end

  def roles
    user_roles.pluck(:role)
  end

  private

  def add_referal_code
    update_columns(referal_code: "#{email.split('@')[0][0..3]}_#{id}")
  end
end

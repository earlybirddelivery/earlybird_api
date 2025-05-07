class Customer < ApplicationRecord
  validates :mobile_number, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validate :mobile_and_email_uniquness
  has_one :user, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_one_attached :display_pic, dependent: :destroy
  has_many :address_details, as: :addressable, dependent: :destroy
  has_many :crm_customer_mappings, dependent: :destroy
  after_create :setup_cart
  after_save :setup_user

  accepts_nested_attributes_for :address_details, allow_destroy: true
  def create_user(params)
    user = User.create!(email: email, mobile_number: mobile_number, password: params[:password], customer_id: id)
    user.user_roles.create!(role: ReferenceDatum::KEY_CUSTOMER)
    user
  end

  def post_signup(user_params, current_user)
    create_user(user_params)
    CrmCustomerMapping.create!(crm_id: current_user.id, customer_id: id, start_date: Time.zone.today,
                               end_date: Time.zone.today + 10_000.days, active: true)
  end

  def address_detail
    address_details.first
  end

  def self.filter(current_user)
    return current_user.customers if current_user.crm?
    return unless ReferenceDatum::KEY_ADMIN_ACCESS.include?(user.roles)

    Customer.all
  end

  def display_pic_url
    return unless display_pic.attached?

    display_pic.url
  end

  private

  def setup_cart
    Cart.create!(customer_id: id)
  end

  def mobile_and_email_uniquness
    return unless User.where.not(id: user&.id).find_by(email: email, mobile_number: mobile_number)

    raise(ArgumentError, 'Email or Mobile Number already exist')
  end

  def setup_user
    return unless user && email_previously_changed?

    user.update!(email: email)
  end
end

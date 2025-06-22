class Order < ApplicationRecord
  include OrderRazorpay
  # include SubscriptionSetup
  include OrderConstants

  STATUS_OPTIONS = [
    CREATED, ORDER_PLACED, PAYMENT_PENDING, OUT_FOR_DELIVERY, DELIVERED, FAILED_TO_DELIVER,
    CANCELLED
  ].freeze
  ADMIN_STATUS_OPTIONS = [
    CREATED, PAYMENT_PENDING, RECEIVED, READY_TO_PICKUP,
    OUT_FOR_DELIVERY, DELIVERED, DELIVERY_FAILED, CANCELLED, ACTIVE, EXPIRED
  ].freeze
  SUBSCRIPTION_STATUS = [CREATED, ACTIVE, PAYMENT_PENDING, EXPIRED, CANCELLED].freeze

  validates :status, inclusion: { in: STATUS_OPTIONS }, if: -> { one_time_order? }
  validates :status, inclusion: { in: SUBSCRIPTION_STATUS }, if: -> { subscription_order? }
  validates :admin_status, inclusion: { in: ADMIN_STATUS_OPTIONS }

  belongs_to :customer, optional: true
  belongs_to :delivery_boy, optional: true
  belongs_to :address_detail, optional: true
  belongs_to :parent, class_name: 'Order', optional: true
  has_many :order_items, dependent: :destroy
  has_one :order_review, dependent: :destroy
  has_one :order_razor_pay_information, dependent: :restrict_with_error

  after_save :modify_status, if: lambda {
                                   payment_method_previously_changed? && payment_method == CASH_ON_DELIVERY
                                 }

  accepts_nested_attributes_for :order_items
  accepts_nested_attributes_for :order_review

  default_scope { where(parent_id: nil) }
  scope :packed_order, -> { order(packed: :desc, created_at: :desc) }
  scope :created_order, -> { reorder(created_at: :desc) }
  scope :remove_unfinished_orders, -> { where.not(status: CREATED) }

  def subscription_order?
    order_type == SUBSCRIPTION
  end

  def one_time_order?
    order_type == OrderConstants::ONE_TIME_DELIVERY
  end

  def process_after_creation(customer_id = nil)
    order_columns = generate_order_autofill_data(customer_id)
    update!(order_columns)
  end

  def self.filter(params, current_user, _user_roles = nil, count = false)
    return if params.blank?

    if current_user.admin?
      admin_orders(params, count)
    elsif current_user.crm? || current_user.customer?
      customer_orders(params, current_user, count)
    end
  end

  def self.admin_orders(params, count)
    orders = Order.remove_unfinished_orders
    orders = apply_common_filters(orders, params)

    if count
      return orders.count
    end

    orders.packed_order.includes(
      :delivery_boy, :customer, :address_detail, :order_review,
      order_items: %i[product product_variant]
    )
  end

  def self.customer_orders(params, current_user, count)
    orders = Order.remove_unfinished_orders
                  .where('customer_id = ? OR orders.created_by = ?', current_user.customer_id, current_user.id)
    orders = apply_common_filters(orders, params)

    if count
      return orders.count
    end

    orders.left_outer_joins(:order_items, :customer)
          .group('orders.id', 'customers.first_name', 'customers.last_name')
          .select('orders.*, COUNT(order_items.id) AS item_count, CONCAT(customers.last_name, \' \', customers.first_name) AS customer_name')
          .reorder(created_at: :desc)
  end

  private

  def self.apply_common_filters(orders, params)
    orders = orders.where(order_type: params[:order_type]) if params[:order_type].present?
    orders = orders.where(status: params[:status]) if params[:status].present? && params[:status] != 'all'
    orders = orders.where(admin_status: params[:admin_status]) if params[:admin_status].present?

    if params[:ordered_from].present? && params[:ordered_to].present?
      from = Time.zone.parse(params[:ordered_from]).beginning_of_day
      to = Time.zone.parse(params[:ordered_to]).end_of_day
      orders = orders.where(created_at: from..to)
    end

    if params[:delivered_from].present? && params[:delivered_to].present?
      from = Time.zone.parse(params[:delivered_from]).beginning_of_day
      to = Time.zone.parse(params[:delivered_to]).end_of_day
      orders = orders.where(delivery_date: from..to)
    end

    orders
  end

  def subscription?
    order_type == SUBSCRIPTION
  end

  def remove_cart_items
    customer.cart.cart_items.where(cart_item_type: order_type).destroy_all
  end

  def generate_order_autofill_data(customer_id, delivery_date = nil)
    bill = order_items.pluck(:cost).compact.sum
    cgst = ENV['cgst'].to_i * bill
    sgst = ENV['sgst'].to_i * bill
    today_date = Time.zone.now.to_date
    {
      orderid: "OID#{Time.zone.today.strftime('%Y%m%d')}#{id}",
      customer_id: customer_id || User.current_user&.customer_id || parent.customer_id,
      bill: bill,
      cgst: cgst,
      sgst: sgst,
      gst: cgst + sgst,
      delivery_fee: 0,
      total_bill: gst.to_i + bill.to_i,
      status: subscription_order? ? ACTIVE : ORDER_PLACED,
      date_of_order: parent&.date_of_order || Time.zone.now,
      delivery_date: delivery_date || Time.zone.now.hour < 20 ? today_date + 1.day : today_date + 2.days
    }
  end

  def modify_status
    if subscription?
      update!(status: ACTIVE, admin_status: ACTIVE)
    else
      update!(status: ORDER_PLACED, admin_status: RECEIVED)
    end
    remove_cart_items
  end

  def delivery_boy_assignment
    raise(ArgumentError, 'Delivery boy should be assigned to move it for delivery')
  end
end

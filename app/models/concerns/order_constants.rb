module OrderConstants
  extend ActiveSupport::Concern
  CREATED = 'Created'.freeze
  ORDER_PLACED = 'Order Placed'.freeze
  PAYMENT_PENDING = 'Payment Pending'.freeze
  OUT_FOR_DELIVERY = 'Out for Delivery'.freeze
  DELIVERED = 'Delivered'.freeze
  FAILED_TO_DELIVER = 'Failed to deliver'.freeze
  CANCELLED = 'Cancelled'.freeze
  RECEIVED = 'Received'.freeze
  READY_TO_PICKUP = 'Ready to pickup'.freeze
  DELIVERY_FAILED = 'Delivery Failed'.freeze
  ACTIVE = 'Active'.freeze
  EXPIRED = 'Expired'.freeze
  ONE_TIME_DELIVERY = 'One Time Delivery'.freeze
  SUBSCRIPTION = 'Subscription'.freeze
  CASH_ON_DELIVERY = 'Cash On Delivery'.freeze
  ONLINE_PAYMENT = 'Online Payment'.freeze
end

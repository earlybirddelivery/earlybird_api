class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :orderid, :total_bill, :date_of_order, :bill, :delivery_fee, :gst, :order_type,
             :payment_method, :packed, :admin_status, :delivery_date, :total_items, :amount_paid_offline, :failed_reason
  belongs_to :customer, serializer: CustomerBasicSerializer
  belongs_to :delivery_boy, serializer: DeliveryBoyBasicSerializer
  belongs_to :address_detail
  has_many :order_items, serializer: OrderItemBasicSerializer
  has_one :order_review
end

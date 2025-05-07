class OrderCreateSerializer < ActiveModel::Serializer
  attributes :id, :orderid, :razorpay_order_id, :status, :razor_pay_status, :date_of_order, :cgst, :sgst, :bill,
             :delivery_fee, :payment_method, :delivery_date, :total_bill, :amount_paid_offline, :failed_reason,
             :order_type
  belongs_to :address_detail
  has_many :order_items, serializer: OrderItemSerializer
  has_one :order_review
end

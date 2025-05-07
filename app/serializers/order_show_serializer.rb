class OrderShowSerializer < ActiveModel::Serializer
  attributes :id, :status, :orderid, :total_bill, :date_of_order, :cgst, :sgst, :bill, :delivery_fee, :gst,
             :order_type,
             :payment_method, :packed, :admin_status, :delivery_date, :amount_paid_offline, :failed_reason,
             :cancel_reason, :issue_description
  belongs_to :customer
  belongs_to :delivery_boy
  belongs_to :address_detail
  has_many :order_items, serializer: OrderItemSerializer
  has_one :order_review
end

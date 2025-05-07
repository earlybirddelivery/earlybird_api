class OrderDeliveryTaskSerializer < ActiveModel::Serializer
  attributes :id, :status, :orderid, :total_bill, :date_of_order, :bill, :delivery_fee, :gst,
             :payment_method, :admin_status, :delivery_date, :total_items, :picked, :amount_paid_offline, :failed_reason
  belongs_to :customer, serializer: CustomerBasicSerializer
  belongs_to :address_detail
  has_many :order_items, serializer: OrderItemBasicSerializer
end

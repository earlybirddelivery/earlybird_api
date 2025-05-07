class OrderCustomerViewSerializer < ActiveModel::Serializer
  attributes :id, :status, :orderid, :total_bill, :date_of_order, :item_count, :delivery_date,
             :amount_paid_offline, :failed_reason, :order_type
end

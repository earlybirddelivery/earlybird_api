class DeliveryTaskIndexSerializer < ActiveModel::Serializer
  attributes :id, :total_bill, :shift, :start_time, :end_time, :area, :status
  belongs_to :dealer, serializer: DealerSimpleSerializer
  has_many :orders, serializer: OrderDeliveryTaskSerializer
end

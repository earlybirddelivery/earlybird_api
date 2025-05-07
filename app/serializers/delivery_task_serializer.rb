class DeliveryTaskSerializer < ActiveModel::Serializer
  attributes :id, :total_bill, :shift, :start_time, :end_time, :area
  belongs_to :dealer
end

class ReferenceDatumSerializer < ActiveModel::Serializer
  attributes :id, :data_type, :label, :short_key
end

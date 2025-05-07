class AddressDetailSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :door_no, :mobile_number, :delivery_line_1, :delivery_line_2, :area, :city, :district, :state, :pincode,
             :land_mark, :address_type, :primary, :location
  def location
    LocationSerializer.new(object.location, root: false).as_json
  end
end

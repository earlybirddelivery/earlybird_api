module CustomTokenResponse
  def body
    additional_data = {}

    if (resource_owner_id = @token&.resource_owner_id)
      if (user = User.find_by(id: resource_owner_id))
        additional_data[:user] = ActiveModelSerializers::SerializableResource.new(user).as_json
      end
    end

    super.merge(additional_data)
  end
end

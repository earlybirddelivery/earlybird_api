module V1
  class AddressDetailsController < AccessController
    before_action :set_address_detail, only: %i[show update destroy]

    # GET /address_details
    def index
      authorize(AddressDetail)
      @address_details = AddressDetail.filter(customer || current_user.customer)
      render(json: @address_details, each_serializer: AddressDetailSerializer, status: :ok)
    end

    # GET /AddressDetail/1
    def show
      authorize(@address_detail)
      render(json: @address_detail, status: :ok)
    end

    # POST /AddressDetail
    def create
      authorize(AddressDetail)
      @address_detail = AddressDetail.create!(address_detail_params)
      render(json: @address_detail, status: :created, serializer: AddressDetailSerializer)
    end

    # PATCH/PUT /AddressDetail/1
    def update
      authorize(@address_detail)
      @address_detail.update!(address_detail_params)
      render(json: @address_detail, serializer: AddressDetailSerializer, status: :ok)
    end

    # DELETE /AddressDetail/1
    def destroy
      authorize(@address_detail)
      @address_detail.update!(deleted_at: Time.zone.now)
      head(:no_content)
    end

    private

    def customer
      @customer ||= Customer.find(params[:customer_id]) if params[:customer_id]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_address_detail
      @address_detail = AddressDetail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def address_detail_params
      addressable_type, addressable_id = case 'true'
                                         when current_user.customer?.to_s
                                           ['Customer', current_user.customer_id]
                                         when current_user.delivery_boy?.to_s
                                           ['DeliveryBoy', current_user.delivery_boy_id]
                                         end
      params[:address_detail][:addressable_type] = addressable_type
      params[:address_detail][:addressable_id] = addressable_id
      permitted_attributes(AddressDetail)
    end
  end
end

module V1
  class DeliveryBoysController < V1::AccessController
    before_action :set_delivery_boy, only: %i[show update]

    # GET /delivery_boys
    def index
      authorize(DeliveryBoy)
      @delivery_boys = DeliveryBoy.all
      render(json: @delivery_boys)
    end

    # GET /delivery_boys/1
    def show
      render(json: @delivery_boy)
    end

    # POST /delivery_boys
    def create
      authorize(DeliveryBoy)
      @delivery_boy = DeliveryBoy.create!(delivery_boy_params)
      render(json: @delivery_boy, status: :created, serializer: DeliveryBoySerializer)
    end

    # PATCH/PUT /delivery_boys/1
    def update
      authorize(DeliveryBoy)
      @delivery_boy.update!(delivery_boy_params)
      render(json: @delivery_boy, status: :ok)
    end

    # DELETE /delivery_boys/1
    # def destroy
    #   @delivery_boy.destroy
    #   head :no_content
    # end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_boy
      @delivery_boy = DeliveryBoy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def delivery_boy_params
      permitted_attributes(DeliveryBoy)
    end
  end
end

module V1
  class OrderItemsController < AccessController
    before_action :set_order_item, only: %i[pause_subscription resume_subscription]

    def pause_subscription
      authorize(@order_item)
      @order_item.update!(pause_until: params[:order_item][:pause_until])
      render(json: @order_item, status: :ok, serializer: OrderItemSerializer, include: '**')
    end

    def resume_subscription
      authorize(@order_item)
      @order_item.update!(pause_until: nil)
      render(json: @order_item, status: :ok, serializer: OrderItemSerializer, include: '**')
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end
  end
end

module V1
  module DeliveryBoyOrder
    class OrdersController < AccessController
      def update
        authorize(@order, policy_class: ::DeliveryBoyOrder::OrderPolicy)
        order.update!(order_params)
        render(json: @_order, serializer: OrderDeliveryTaskSerializer, status: :ok, include: '**')
      end

      private

      def order
        @_order ||= Order.find(params[:id])
      end

      def order_params
        order_params = params.require(:order).permit(%i[admin_status amount_paid_offline picked failed_reason])
        order_params[:status] = case params[:admin_status]
                                when Order::OUT_FOR_DELIVERY
                                  Order::OUT_FOR_DELIVERY
                                when Order::DELIVERED
                                  Order::DELIVERED
                                when Order::DELIVERY_FAILED
                                  Order::FAILED_TO_DELIVER
                                when Order::CANCELLED
                                  Order::CANCELLED
                                end
        order_params
      end
    end
  end
end

module V1
  class OrdersController < AccessController
    before_action :set_order,
                  only: %i[
                    show update generate_razor_pay_order_id place_order proceed_to_pay
                    payment_confirmation out_for_delivery delivered cancel raise_issue
                  ]
    before_action :set_user_roles
    # GET /orders
    def index
      authorize(Order)
      total_count = Order.filter(params, current_user, @user_roles, true)
      @orders = Order.filter(params, current_user, @user_roles).page(params[:page]).per(per_page)
      if @user_roles[:is_customer]
        render(json: @orders, each_serializer: OrderCustomerViewSerializer, meta: { total_count: total_count },
               status: :ok, include: '**')
      elsif @user_roles[:is_admin]
        render(json: @orders, each_serializer: OrderSerializer, meta: { total_count: total_count }, status: :ok,
               include: '**'
        )
      elsif current_user.crm?
        render(json: @orders, each_serializer: OrderCrmViewSerializer, meta: { total_count: total_count },
               status: :ok, include: '**')
      end
    end

    # GET /orders/1
    def show
      authorize(@order)
      render(json: @order, status: :ok, serializer: OrderShowSerializer, include: '**')
    end

    # POST /orders
    def create
      authorize(Order)
      begin
        @order = Order.create!(order_params)
        customer_id = current_user.crm? ? params[:order][:customer_id] : current_user.customer_id
        @order.process_after_creation(customer_id)
        render(json: @order, status: :created, serializer: OrderCreateSerializer, include: '**')
      rescue ActiveRecord::RecordInvalid => e
        render(json: { success: false, message: "Order creation failed", errors: e.record.errors.full_messages }, status: :unprocessable_entity)
      rescue StandardError => e
        render(json: { success: false, message: "Order creation failed", errors: [e.message] }, status: :unprocessable_entity)
      end
    end

    def update
      authorize(@order)
      if @order.update(order_params)
        render(json: @order, serializer: OrderCreateSerializer, status: :ok, include: '**')
      else
        render(json: { success: false, message: "Order update failed", errors: @order.errors.full_messages }, status: :unprocessable_entity)
      end
    end
    
    def place_order
      authorize(@order)
      if @order.update(order_params)
        render(json: @order, serializer: OrderCreateSerializer, status: :ok, include: '**')
      else
        render(json: { success: false, message: "Order placement failed", errors: @order.errors.full_messages }, status: :unprocessable_entity)
      end
    end
    
    def proceed_to_pay
      authorize(@order)
      if @order.update(order_params)
        render(json: @order, serializer: OrderCreateSerializer, status: :ok, include: '**')
      else
        render(json: { success: false, message: "Proceed to pay failed", errors: @order.errors.full_messages }, status: :unprocessable_entity)
      end
    end
    
    def generate_razor_pay_order_id
      authorize(@order)
      begin
        @order.generate_razor_pay_order_id(params[:order][:address_detail_id])
        render(json: @order, serializer: OrderCreateSerializer, status: :ok, include: '**')
      rescue StandardError => e
        render(json: { success: false, message: "Failed to generate Razorpay order ID", errors: [e.message] }, status: :unprocessable_entity)
      end
    end
    
    def out_for_delivery
      authorize(@order)
      if @order.update(status: Order::OUT_FOR_DELIVERY, admin_status: Order::OUT_FOR_DELIVERY)
        render(json: @order, serializer: OrderShowSerializer, status: :ok, include: '**')
      else
        render(json: { success: false, message: "Failed to mark as out for delivery", errors: @order.errors.full_messages }, status: :unprocessable_entity)
      end
    end
    
    def delivered
      authorize(@order)
      if @order.update(status: Order::DELIVERED, admin_status: Order::DELIVERED)
        render(json: @order, serializer: OrderShowSerializer, status: :ok, include: '**')
      else
        render(json: { success: false, message: "Failed to mark as delivered", errors: @order.errors.full_messages }, status: :unprocessable_entity)
      end
    end
    
    def payment_confirmation
      authorize(@order)
      begin
        payment_received = @order.confirm_payment(params)
        render(json: { payment_received: payment_received }, status: :ok)
      rescue StandardError => e
        render(json: { success: false, message: "Payment confirmation failed", errors: [e.message] }, status: :unprocessable_entity)
      end
    end
    
    def cancel
      authorize(@order)
      if @order.update(status: Order::CANCELLED, admin_status: Order::CANCELLED, cancel_reason: params[:order][:cancel_reason])
        render(json: @order, serializer: OrderShowSerializer, status: :ok, include: '**')
      else
        render(json: { success: false, message: "Order cancellation failed", errors: @order.errors.full_messages }, status: :unprocessable_entity)
      end
    end
    
    def raise_issue
      authorize(@order)
      if @order.update(issue_description: params[:order][:issue_description])
        render(json: @order, serializer: OrderShowSerializer, status: :ok, include: '**')
      else
        render(json: { success: false, message: "Failed to raise issue", errors: @order.errors.full_messages }, status: :unprocessable_entity)
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params[:order][:order_items_attributes] = params[:order].delete(:order_items)
      params[:order][:order_review_attributes] = params[:order].delete(:order_review)
      permitted_attributes(Order)
    end
  end
end

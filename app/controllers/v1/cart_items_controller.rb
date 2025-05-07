module V1
  class CartItemsController < AccessController
    before_action :set_cart, only: %i[create index]
    before_action :set_cart_item, only: %i[show update destroy]

    # GET carts/:id/cart_items
    def index
      authorize(@cart, policy_class: CartItemPolicy)
      @cart_items = CartItem.filter(params)

      render(json: @cart_items, each_serializer: CartItemSerializer, status: :ok)
    end

    # POST carts/:id/cart_items
    def create
      authorize(@cart, policy_class: CartItemPolicy)
      @cart_item = @cart.cart_items.create!(cart_item_params)
      render(json: @cart_item, status: :created)
    end

    def update
      authorize(@cart_item)
      @cart_item.update!(cart_item_params)
      # To do hard reload should not be done
      render(json: @cart_item.reload, status: :ok)
    end

    # DELETE carts/:id/cart_items/:id
    def destroy
      authorize(@cart_item)
      @cart_item.destroy!
      head(:no_content)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:cart_id])
    end

    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cart_item_params
      params[:cart_item][:subscriber_id] = current_user.id if params[:cart_item][:cart_item_type] == Order::SUBSCRIPTION
      permitted_attributes(CartItem)
    end
  end
end

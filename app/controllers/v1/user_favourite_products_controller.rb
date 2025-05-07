module V1
  class UserFavouriteProductsController < AccessController
    before_action :set_user_favourite_product, only: [:remove_from_favourites]

    # GET users/:id/user_favourite_products
    def index
      @favourite_products = user_favourite_products
      render(json: @favourite_products, each_serializer: ProductIndexSerializer, include: '**', status: :ok)
    end

    # POST /user_favourite_products
    def create
      authorize(UserFavouriteProduct)
      @user_favourite_product = current_user.user_favourite_products.create!(user_favourite_product_params)
      favourite_product = @user_favourite_product.favourite_product
      favourite_product.favourite_product = true
      render(json: favourite_product, serializer: ProductIndexSerializer, status: :created)
    end

    # DELETE /user_favourite_products/1
    def remove_from_favourites
      authorize(@user_favourite_product)
      @user_favourite_product.destroy!
      favourite_product = @user_favourite_product.favourite_product
      favourite_product.favourite_product = false
      render(json: favourite_product, serializer: ProductIndexSerializer, status: :created)
    end

    private

    def set_user_favourite_product
      @user_favourite_product = current_user.user_favourite_products.find_by(favourite_product_id: params[:favourite_product_id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_favourite_product_params
      permitted_attributes(UserFavouriteProduct)
    end

    def user_favourite_products
      favourite_products = current_user.favourite_products
      favourite_products.map { |product| product.favourite_product = true }
      favourite_products
    end
  end
end

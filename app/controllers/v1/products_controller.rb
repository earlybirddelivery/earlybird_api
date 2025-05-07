module V1
  class ProductsController < AccessController
    include SoftDelete

    before_action :set_brand, only: %i[create]

    # GET /products
    def index
      authorize(Product)
      @products = Product.filter(params, super_list_access)
      total_count = @products.count
      @products = @products.page(params[:page]).per(per_page)
      if super_list_access
        render(json: @products, each_serializer: ProductSuperListIndexSerializer, meta: { total_count: total_count }, status: :ok, include: '**')
      else
        populate_favourite_product_flag(@products)
        render(json: @products, each_serializer: ProductIndexSerializer, meta: { total_count: total_count }, status: :ok, include: '**')
      end
    end

    # GET /products/1
    def show
      authorize(record)
      record.favourite_product = current_user.favourite_products.where(id: record.id).any?
      render(json: record, serializer: ProductIndexSerializer, status: :ok, include: '**')
    end

    def explore
      authorize(Product)
      @products = Product.all
      render(json: @products, each_serializer: ProductExploreSerializer, status: :ok, include: '**')
    end

    # POST /products
    def create
      authorize(Product)
      @record = @brand.products.create!(product_params)
      render(json: @record, status: :created, serializer: ProductIndexSerializer)
    end

    # PATCH/PUT /products/1
    def update
      authorize(record)
      record.update!(product_params)
      render(json: record, serializer: ProductIndexSerializer, status: :ok)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:brand_id])
    end

    def record
      @record ||= Product.find(params[:id])
    end

    def populate_favourite_product_flag(products)
      favourite_products = User.current_user.favourite_products.ids
      products.map do |product|
        product.favourite_product = favourite_products.include?(product.id)
      end
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      permitted_attributes(Product)
    end
  end
end

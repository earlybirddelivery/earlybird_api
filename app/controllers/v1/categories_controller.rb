module V1
  class CategoriesController < AccessController
    before_action :set_category, only: %i[show update destroy]

    # GET /categories
    def index
      authorize(Category)
      @categories = Category.all
      render(json: @categories, each_serializer: CategorySerializer, status: :ok)
    end

    # GET /categories/1
    def show
      authorize(@category)
      render(json: @category, status: :ok)
    end

    # POST /categories
    def create
      authorize(Category)
      @category = Category.create!(category_params)
      render(json: @category, status: :created, serializer: CategorySerializer)
    end

    # PATCH/PUT /categories/1
    def update
      authorize(@category)
      @category.update!(category_params)
      render(json: @category, serializer: CategorySerializer, status: :ok)
    end

    # DELETE /categories/1
    def destroy
      authorize(@category)
      @category.destroy!
      head(:no_content)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      permitted_attributes(Category)
    end
  end
end

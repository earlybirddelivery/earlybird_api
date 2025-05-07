module V1
  class BrandsController < AccessController
    include SoftDelete

    # GET /brands
    def index
      authorize(Brand)
      @brands = Brand.all
      render(json: @brands, each_serializer: BrandSerializer, status: :ok)
    end

    # GET /brands/1
    def show
      authorize(record)
      render(json: record, serializer: BrandSerializer, status: :ok)
    end

    # POST /brands
    def create
      authorize(Brand)
      record = Brand.create!(brand_params)
      render(json: record, serializer: BrandSerializer, status: :created)
    end

    # PATCH/PUT /brands/1
    def update
      authorize(record)
      record.update!(brand_params)
      render(json: record, serializer: BrandSerializer, status: :ok)
    end

    # DELETE /brands/1
    def destroy
      authorize(record)
      record.destroy
      head(:no_content)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def record
      @record ||= Brand.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def brand_params
      permitted_attributes(Brand)
    end
  end
end

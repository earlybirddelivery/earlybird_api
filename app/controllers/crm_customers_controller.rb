class CrmCustomerMappingsController < ApplicationController
  before_action :set_crm_customer, only: %i[ show update destroy ]

  # GET /crm_customer_mappings
  def index
    @crm_customer_mappings = CrmCustomerMapping.all

    render json: @crm_customer_mappings
  end

  # GET /crm_customer_mappings/1
  def show
    render json: @crm_customer_mapping
  end

  # POST /crm_customer_mappings
  def create
    @crm_customer_mapping = CrmCustomerMapping.new(crm_customer_params)

    if @crm_customer_mapping.save
      render json: @crm_customer_mapping, status: :created, location: @crm_customer_mapping
    else
      render json: @crm_customer_mapping.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /crm_customer_mappings/1
  def update
    if @crm_customer_mapping.update(crm_customer_params)
      render json: @crm_customer_mapping
    else
      render json: @crm_customer_mapping.errors, status: :unprocessable_entity
    end
  end

  # DELETE /crm_customer_mappings/1
  def destroy
    @crm_customer_mapping.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crm_customer
      @crm_customer_mapping = CrmCustomerMapping.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crm_customer_params
      params.fetch(:crm_customer, {})
    end
end

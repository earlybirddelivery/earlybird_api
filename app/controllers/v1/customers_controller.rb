module V1
  class CustomersController < V1::AccessController
    before_action :set_customer, only: %i[show update destroy]
    skip_before_action :doorkeeper_authorize!, only: [:sign_up]

    # GET /customers
    def index
      authorize(Customer)
      @customers = Customer.filter(current_user)
      render(json: @customers, status: :ok, each_serializer: CustomerSerializer, include: '**')
    end

    # GET /customers/1
    def show
      authorize(@customer)
      render(json: @customer, status: :ok, serializer: CustomerShowSerializer)
    end

    # POST /customers
    def sign_up
      ActiveRecord::Base.transaction do
        @customer = Customer.create!(customer_params)
        @customer.post_signup(params['customer'], current_user)
      end
      # user.send_otp
      render(json: @customer, status: :created)
    rescue ActiveRecord::RecordInvalid => e
      render(json: { message: e.record.errors.full_messages }, status: :unprocessable_entity)
    end

    # PATCH/PUT /customers/1
    def update
      if @customer.update(customer_params)
        render(json: @customer)
      else
        render(json: @customer.errors, status: :unprocessable_entity)
      end
    end

    # DELETE /customers/1
    def destroy
      @customer.destroy
    end

    # GET /customers/search?query=some_text
    def search
      authorize(Customer)
      query = params[:query].to_s.strip

      customers = Customer.where('first_name ILIKE ? OR last_name ILIKE ? OR mobile_number ILIKE ?', "%#{query}%", "%#{query}%", "%#{query}%")
                         .select(:id, :first_name, :last_name, :mobile_number)
                         .limit(10)

      render json: customers, each_serializer: CustomerSearchSerializer, status: :ok
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def customer_params
      permitted_attributes(Customer)
    end
  end
end

module OrderRazorpay
  extend ActiveSupport::Concern
  def confirm_payment(params)
    payment_signature_information = payment_information(params)
    update!(payment_signature_information)
    if Razorpay::Utility.verify_payment_signature(payment_signature_information)
      response = Razorpay::Order.fetch(razorpay_order_id).attributes
      status, admin_status = if response['amount_paid'] >= (total_bill * 100)
                               [
                                 Order::ORDER_PLACED,
                                 Order::RECEIVED
                               ]
                             else
                               [
                                 Order::PAYMENT_PENDING, Order::PAYMENT_PENDING
                               ]
                             end
      update!(razor_pay_status: response['status'], razor_pay_repsonse: response,
              amount_paid: response['amount_paid'], status: status, admin_status: admin_status
      )
    else
      update!(status: Order::PAYMENT_PENDING)
    end
    OrderInformationWorker.perform_async(razorpay_order_id)
    if status == Order::ORDER_PLACED
      SubscriptionSetupWorker.perform_async(id) if subscription?
      true
    end
    false
  end

  def generate_razor_pay_order_id(address_detail_id)
    return if razorpay_order_id

    response = Razorpay::Order.create(amount: Integer(total_bill * 100), currency: 'INR', receipt: orderid.to_s)
    razorpay_order_id = response.attributes['id']
    update!(address_detail_id: address_detail_id, payment_method: Order::ONLINE_PAYMENT,
            razorpay_order_id: razorpay_order_id, status: Order::PAYMENT_PENDING
    )
    remove_cart_items
    OrderInformationWorker.perform_async(razorpay_order_id)
  end

  def capture_basic_razorpay_info(razorpay_order_data)
    order_razor_pay_information ||= OrderRazorPayInformation.create!(order_razor_pay_information_params(razorpay_order_data))
    order_razor_pay_information.update!(order_razor_pay_information_params(razorpay_order_data))
    order_razor_pay_information
  end

  private

  def payment_information(params)
    {
      razorpay_payment_id: params[:payment_information][:razorpay_payment_id],
      razorpay_signature: params[:payment_information][:razorpay_signature],
      razorpay_order_id: params[:payment_information][:razorpay_order_id]
    }
  end

  def order_razor_pay_information_params(response)
    params = {}
    params[:razorpay_order_id] = response['id']
    params[:status] = response['status']
    params[:order_id] = id
    params[:entity] = response['entity']
    params[:amount] = response['amount']
    params[:amount_paid] = response['amount_paid']
    params[:amount_due] = response['amount_due']
    params[:currency] = response['currency']
    params[:receipt] = response['receipt']
    params[:offer_id] = response['offer_id']
    params[:attempts] = response['attempts']
    params[:notes] = response['notes']
    params[:razor_pay_created_at] = response['created_at']
    params[:razorpay_payment_id] = razorpay_payment_id
    params[:razorpay_signature] = razorpay_signature
    params
  end
end

class OrderRazorPayInformation < ApplicationRecord
  belongs_to :order
  has_many :razorpay_payments, dependent: :restrict_with_error

  def capture_payment_data(razorpay_order_data)
    payment_information = razorpay_order_data.payments.attributes
    payment_information['items'].map do |payment_information|
      next if RazorpayPayment.find_by(payment_id: payment_information['id'])

      razorpay_payments.create!(razorpay_payment_params(payment_information))
    end
  end

  private

  def razorpay_payment_params(payment_information)
    params = {}
    params[:payment_id] = payment_information['id']
    params[:entity] = payment_information['entity']
    params[:amount] = payment_information['amount']
    params[:currency] = payment_information['currency']
    params[:payment_status] = payment_information['status']
    params[:invoice_id] = payment_information['invoice_id']
    params[:international] = payment_information['international']
    params[:method] = payment_information['method']
    params[:amount_refunded] = payment_information['amount_refunded']
    params[:refund_status] = payment_information['refund_status']
    params[:captured] = payment_information['captured']
    params[:description] = payment_information['description']
    params[:card_id] = payment_information['card_id']
    params[:bank] = payment_information['bank']
    params[:wallet] = payment_information['wallet']
    params[:vpa] = payment_information['vpa']
    params[:email] = payment_information['email']
    params[:contact] = payment_information['contact']
    params[:notes] = payment_information['notes']
    params[:fee] = payment_information['fee']
    params[:tax] = payment_information['tax']
    params[:error_code] = payment_information['error_code']
    params[:error_description] = payment_information['error_description']
    params[:error_source] = payment_information['error_source']
    params[:error_step] = payment_information['error_step']
    params[:error_reason] = payment_information['error_reason']
    params[:acquirer_data] = payment_information['acquirer_data']
    params[:payment_initiated_at] = payment_information['created_at']
    params
  end
end

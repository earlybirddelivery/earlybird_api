module OrderRazorpay
  class OrderData
    def self.capture_razor_pay_info(razorpay_order_id)
      order = Order.find_by(razorpay_order_id: razorpay_order_id)
      razorpay_order_data = Razorpay::Order.fetch(razorpay_order_id)

      order_razor_pay_information = order.capture_basic_razorpay_info(razorpay_order_data.attributes)
      order_razor_pay_information.capture_payment_data(razorpay_order_data)
    end
  end
end

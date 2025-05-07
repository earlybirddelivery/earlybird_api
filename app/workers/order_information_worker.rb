class OrderInformationWorker
  include Sidekiq::Worker
  sidekiq_options queue: :razorpay

  def perform(razorpay_order_id)
    OrderRazorpay::OrderData.capture_razor_pay_info(razorpay_order_id)
  end
end

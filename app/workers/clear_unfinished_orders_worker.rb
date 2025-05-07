class ClearUnfinishedOrdersWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'razorpay'
  def perform
    Order.where('created_at <  ? and status = ?', Time.zone.now - 1.hour, Order::CREATED).destroy_all
  end
end

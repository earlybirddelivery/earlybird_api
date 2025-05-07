class SubscriptionSetupWorker
  include Sidekiq::Worker
  sidekiq_options queue: :subscription

  def perform(order_id)
    Subscription.new(order_id).generate_deliverable_orders
  end
end

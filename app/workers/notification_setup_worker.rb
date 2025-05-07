class NotificationSetupWorker
  include Sidekiq::Worker
  sidekiq_options queue: :fcm

  def perform(fcm_registration_id)
    FcmRegistrationId.find(fcm_registration_id).process_notification_setup
  end
end

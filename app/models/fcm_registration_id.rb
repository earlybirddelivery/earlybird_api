class FcmRegistrationId < ApplicationRecord
  belongs_to :user
  validates :registration_id, uniqueness: true

  after_create :process_after_creation

  def process_notification_setup
    user.setup_notification_key(registration_id)
    add_registration_id_to_global_topic
  end

  private

  def process_after_creation
    NotificationSetupWorker.perform_async(id)
  end

  def add_registration_id_to_global_topic
    Firebase::Setup.subscribe_to_topic('global', registration_id)
  end
end

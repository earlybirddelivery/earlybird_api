class ManualNotification < ApplicationRecord
  belongs_to :fcm_topic
  has_one_attached :notification_poster, dependent: :destroy
  has_many :published_notifications, dependent: :nullify

  def trigger_notification
    fcm = Firebase::Notification.new(message, notification_poster_url, title, fcm_topic.name, [], click_action)
    response = fcm.send_notification_to_topic
    published_notifications.create!(response_body: response[:body], response_code: response[:status_code],
                                    published_date: Time.zone.today, published_time: Time.zone.now
    )
  end

  def notification_poster_url
    return unless notification_poster.attached?

    notification_poster.url
  end
end

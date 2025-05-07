class PublishedNotification < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :fcm_topic, optional: true
  belongs_to :manual_notification, optional: true
end

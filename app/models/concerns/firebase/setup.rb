module Firebase
  class Setup
    def self.add_user_to_topic(topic, registration_ids)
      $fcm.batch_topic_subscription(topic, registration_ids)
    end

    def self.update_notification_key(key_name, notification_key, registration_id)
      $fcm.add(key_name, ENV['FCM_PROJECT_ID'], notification_key, registration_id)
    end

    def self.generate_notification_key(key_name, registration_ids)
      params = {
        key_name: key_name,
        project_id: ENV['FCM_PROJECT_ID'],
        registration_ids: registration_ids
      }
      $fcm.create(*params.values)
    end

    def self.subscribe_to_topic(topic_name, registration_id)
      $fcm.topic_subscription(topic_name, registration_id)
    end

    def self.batch_topic_subscription(topic_name, rg_ids)
      $fcm.batch_topic_subscription(topic_name, rg_ids)
    end
  end
end

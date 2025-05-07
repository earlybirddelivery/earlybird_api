module Firebase
  class Notification
    def initialize(message = '', image = '', title = '', topic = '', registration_ids = [], click_action = '')
      @notification_params = {}
      @notification_params[:topic] = topic
      notification = {}
      notification[:body] = message
      notification[:image] = image if image
      notification[:title] = title
      notification[:click_action] = click_action if click_action
      @notification_params[:notification] = notification
      @notification_params[:registration_ids] = registration_ids
    end

    def notify_registration_ids
      fcm = $fcm.send(@notification_params[:registration_ids], { notification: @notification_params[:notification] })
      fcm.trigger_notification
      response
    end

    def send_notification_to_topic
      $fcm.send_to_topic(@notification_params[:topic], notification: @notification_params[:notification])
    end
  end
end

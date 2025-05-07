module V1
  class ManualNotificationsController < AccessController
    before_action :set_manual_notification, only: %i[show update destroy]

    # GET /manual_notifications
    def index
      authorize(ManualNotification)
      manual_notifications = ManualNotification.all

      render(json: manual_notifications)
    end

    # GET /manual_notifications/1
    def show
      authorize(manual_notification)
      render(json: manual_notification)
    end

    # POST /manual_notifications
    def create
      authorize(ManualNotification)
      manual_notification = ManualNotification.new(manual_notification_params)

      if manual_notification.save
        render(json: manual_notification, status: :created)
      else
        render(json: manual_notification.errors, status: :unprocessable_entity)
      end
    end

    # PATCH/PUT /manual_notifications/1
    def update
      authorize(manual_notification)
      if manual_notification.update(manual_notification_params)
        render(json: manual_notification)
      else
        render(json: manual_notification.errors, status: :unprocessable_entity)
      end
    end

    def publish_notification
      authorize(manual_notification)
      manual_notification.trigger_notification
      render(json: { message: 'Notification has been published' }, status: :ok)
    end

    # DELETE /manual_notifications/1
    def destroy
      authorize(manual_notification)
      manual_notification.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def manual_notification
      @_manual_notification ||= ManualNotification.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def manual_notification_params
      permitted_attributes(ManualNotification)
    end
  end
end

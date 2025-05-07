module V1
  class DeliveryTasksController < AccessController
    # GET /delivery_tasks
    def index
      authorize(DeliveryTask)
      @delivery_tasks = DeliveryTask.all

      render(json: @delivery_tasks, each_serializer: DeliveryTaskIndexSerializer, status: :ok, include: '**')
    end

    def update
      authorize(delivery_task)
      delivery_task.update!(delivery_task_params)
      render(json: @_delivery_task, serializer: DeliveryTaskIndexSerializer, status: :ok, include: '**')
    end

    private

    def delivery_task
      @_delivery_task ||= DeliveryTask.find(params[:id])
    end

    def delivery_task_params
      params.require(:delivery_task).permit(:status)
    end
  end
end

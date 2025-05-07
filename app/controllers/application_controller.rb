class ApplicationController < ActionController::API
  include Pundit::Authorization
  include ExceptionHandler
  include ActiveStorage::SetCurrent

  def common_response
    render(json: { message: 'route not found' }, status: :ok)
  end

  def index
    render(file: Rails.root.join('public', 'index.html'))
  end
end

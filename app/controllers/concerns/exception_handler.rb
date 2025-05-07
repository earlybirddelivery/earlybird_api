module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  # TODO: Sort out the save problem and these exceptions

  included do
    rescue_from ActiveRecord::InvalidForeignKey do |e|
      render json: { message: e.message }, status: :conflict
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end

    rescue_from JSON::ParserError do |e|
      render json: { message: "Invalid JSON: #{e.message}" }, status: :unprocessable_entity
    end

    rescue_from ArgumentError do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end

    rescue_from ActionController::ParameterMissing do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from Pundit::NotAuthorizedError do |e|
      policy_name = e.policy.class.to_s.underscore
      render json: { message: "You are not allowed for #{policy_name} action" }, status: :forbidden
    end
  end
end

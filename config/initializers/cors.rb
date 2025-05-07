Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # Allows all origins

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: false  # Must be false if origins is '*'
  end
end
Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

schedule_file = 'config/sidekiq_scheduled_jobs.yml'

Sidekiq::Cron::Job.load_from_hash!(YAML.load_file(schedule_file)[Rails.env]) if File.exist?(schedule_file) && Sidekiq.server?

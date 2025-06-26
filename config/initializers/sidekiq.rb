Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

schedule_file = 'config/sidekiq_scheduled_jobs.yml'

Sidekiq::Cron::Job.load_from_hash!(
  YAML.safe_load(File.read(schedule_file), aliases: true)[Rails.env]
) if File.exist?(schedule_file) && Sidekiq.server?
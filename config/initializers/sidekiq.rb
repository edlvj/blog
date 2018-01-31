Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL'), size: 27 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL'), size: 20 }
end
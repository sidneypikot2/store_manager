Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://redis:6379') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://redis:6379') }
end

Sidekiq.configure_server do |config|
  config.logger = Sidekiq::Logger.new($stdout)
end

Sidekiq.strict_args!(false)
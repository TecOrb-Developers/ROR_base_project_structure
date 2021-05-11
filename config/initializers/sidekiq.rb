require 'sidekiq'
require 'sidekiq-status'
require 'sidekiq-cron'
require 'sidekiq/web'

Sidekiq.configure_client do |config|

  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
  
  config.redis = { 
    namespace: "#{ENV['NAMESPACE']}", 
    url: "redis://127.0.0.1:6379/#{ENV['NAMESPACE']=='live' ? 1 : 0}" 
  }

  config.failures_max_count = false
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes # default
  end

  config.redis = { 
    namespace: "#{ENV['NAMESPACE']}",
    url: "redis://127.0.0.1:6379/#{ENV['NAMESPACE']=='live' ? 1 : 0}" 
  }
  config.failures_max_count = false
end

schedule_file = "config/schedule.yml"
if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["#{ENV['SIDEKIQ_USER']}", "#{ENV['SIDEKIQ_PASS']}"]
end

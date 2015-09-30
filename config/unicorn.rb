worker_processes 2
timeout 60
preload_app true

before_fork do |server, worker|
  # Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    p "('Disconnected from ActiveRecord')"
  end

  p "('Disconnected from Redis')"

  sleep 1
end

after_fork do |server, worker|
  # Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    p "('Connected to ActiveRecord')"
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV["REDISTOGO_URL"] }
  end unless ENV["REDISTOGO_URL"].blank?

  p "('Connected to Redis')"
end
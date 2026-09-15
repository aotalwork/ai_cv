require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory savings.
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Turn on fragment caching in view templates.
  config.action_controller.perform_caching = true

  # Cache assets for far-future expiry since they are all digest stamped.
  config.public_file_server.headers = {
    "cache-control" => "public, max-age=#{1.year.to_i}"
  }

  # Store uploaded files on the local file system.
  config.active_storage.service = :local

  # Render terminates SSL before forwarding requests to the Rails app.
  config.assume_ssl = true

  # Force HTTPS in production.
  config.force_ssl = true

  # Keep the health check available without redirecting it.
  config.ssl_options = {
    redirect: {
      exclude: ->(request) { request.path == "/up" }
    }
  }

  # Log to STDOUT.
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::TaggedLogging.logger(STDOUT)

  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Prevent health checks from clogging up the logs.
  config.silence_healthcheck_path = "/up"

  # Don't log deprecations.
  config.active_support.report_deprecations = false

  # Simple in-process cache.
  config.cache_store = :memory_store

  # Simple in-process Active Job adapter.
  config.active_job.queue_adapter = :async

  # Action Mailer host.
  config.action_mailer.default_url_options = {
    host: ENV.fetch("APP_HOST", "localhost")
  }

  # Locale fallbacks.
  config.i18n.fallbacks = true

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Only use :id for inspections in production.
  config.active_record.attributes_for_inspect = [:id]

  # Host authorization can be configured later if needed.
  #
  # config.hosts = [
  #   "example.com"
  # ]
end

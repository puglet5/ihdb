# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.session_store :cache_store

  config.after_initialize do
    Bullet.enable = false
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.add_footer = true
  end

  config.cache_classes = false

  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timer = true
  config.assets.quiet = true

  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :redis_cache_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.active_storage.service = :local

  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []

  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true

  config.file_watcher = ActiveSupport::FileUpdateChecker

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.hosts << '127.0.0.1'

  config.serve_static_assets = false

  config.action_view.image_loading = 'lazy'

  # setup sidekiq logger to work with semantic logger
  # config.semantic_logger.add_appender(io: $stdout, formatter: :color) if Sidekiq.server?

  # config.rails_semantic_logger.semantic = true
  # config.rails_semantic_logger.started    = false
  # config.rails_semantic_logger.processing = true
  # config.rails_semantic_logger.rendered   = false
  # config.log_level = :info
  # config.rails_semantic_logger.quiet_assets = true
  # config.rails_semantic_logger.ap_options = { multiline: true }
  # config.rails_semantic_logger.format = :color
  # config.log_tags = nil

  config.hotwire_livereload.reload_method = :turbo_stream

  Rails.application.routes.default_url_options[:host] = 'localhost:3000'
end

# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'

Bundler.require(*Rails.groups)

module HSDB
  class Application < Rails::Application
    config.load_defaults 7.0

    config.i18n.available_locales = %i[en ru]
    config.i18n.default_locale = :en

    config.time_zone = 'Moscow'

    config.active_job.queue_adapter = :sidekiq

    # config.action_mailer.deliver_later_queue_name = nil
    # config.action_mailbox.queues.routing    = nil

    config.active_storage.queues.mirror = nil
    config.active_storage.track_variants = true

    config.generators do |g|
      g.view_specs false
      g.helper_specs false
      g.component_specs false
    end

    Rails.application.config.active_storage.variant_processor = :mini_magick
    Rails.application.config.active_storage.analyzers.delete ActiveStorage::Analyzer::ImageAnalyzer
    Rails.application.config.active_storage.analyzers.append ActiveStorage::Analyzer::ImageAnalyzer::Vips

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post put delete options]
      end
    end
  end
end

# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'logger'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VueBlog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # config.assets.paths << Rails.root.join('vue-frontend/dist')
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Enable cookies, sessions, and flash for Trestle while maintaining API functionality
    config.api_only = false

    # Add middleware for sessions and cookies needed by Trestle
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: '_vue_blog_session'

    # Add CSRF protection middleware for Trestle
    config.middleware.use ActionDispatch::Flash

    # Configure the session store
    config.session_store :cookie_store, key: '_vue_blog_session'

    # Enable serving of static files like assets from the /public directory
    config.public_file_server.enabled = true

    # Configure Sprockets for asset pipeline
    config.assets.enabled = true

    config.active_job.queue_adapter = :sidekiq
  end
end

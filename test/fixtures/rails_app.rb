# frozen_string_literal: true

require "rails"
require "action_controller/railtie"
require "i_did_mean"

module TestRailsApp
  class Application < Rails::Application
    config.secret_token = "572c86f5ede338bd8aba8dae0fd3a326aabababc98d1e6ce34b9f5"
    config.secret_key_base = "foo"
    config.hosts << "example.org" if config.respond_to?(:hosts)
    config.logger = Logger.new(nil)
    Rails.logger = config.logger
    config.cache_classes = false
    config.eager_load = false
    config.consider_all_requests_local = true
    if defined?(ActiveSupport::EventedFileUpdateChecker)
      config.file_watcher = ActiveSupport::EventedFileUpdateChecker
    end
    config.active_support.test_order = :random

    routes.append do
      root to: "test_rails_app/application#index"
    end
  end

  class ApplicationController < ActionController::Base
    def autofix_me
      "foo"
    end

    def index
      render plain: autofix_me
    end
  end
end

TestRailsApp::Application.initialize!

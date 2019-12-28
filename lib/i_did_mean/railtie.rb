# frozen_string_literal: true

module IDidMean
  class Railtie < ::Rails::Railtie
    initializer("i_did_mean.middleware") do |app|
      app.config.middleware.insert_after(
        ActionDispatch::DebugExceptions,
        IDidMean::Rails::Middleware
      )
    end
  end
end

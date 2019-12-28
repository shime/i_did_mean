# frozen_string_literal: true

module IDidMean
  module Rails
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        begin
          response = @app.call(env)
        rescue StandardError => e
          processor = IDidMean::Processor.new(e)

          raise unless processor.should_process?

          response = handle_exception(processor, env)
        end

        response
      end

      private

      def handle_exception(processor, env)
        processor.call

        ActiveSupport::DescendantsTracker.clear
        ActiveSupport::Dependencies.clear

        @app.call(env)
      end
    end
  end
end

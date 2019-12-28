# frozen_string_literal: true

require "English"

module IDidMean
  def self.call(error)
    processor = Processor.new(error)
    processor.call
  end
end

at_exit do
  IDidMean.call($ERROR_INFO) if $ERROR_INFO
end

require "i_did_mean/error"
require "i_did_mean/processor"
require "i_did_mean/formatter"

if defined?(::Rails)
  require "i_did_mean/rails/middleware"
  require "i_did_mean/railtie"
end

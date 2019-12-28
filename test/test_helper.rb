# frozen_string_literal: true

require "minitest/autorun"
require "minitest/focus"

def skip_on_load_errors
  yield
rescue LoadError # rubocop:disable Lint/SuppressedException
end

module IDidMean::FileTestHelpers
  def replace_text_in_file(path, original, replacement)
    text = File.read(path)
    content = text.gsub(original, replacement)
    File.write(path, content)
  end
end

module Kernel
  def suppress_warnings
    original_verbosity = $VERBOSE
    $VERBOSE = nil
    yield
  ensure
    $VERBOSE = original_verbosity
  end
end

TEMP_FILE_PATH = File.expand_path("tmp.rb", __dir__)

module DidYouMean::TestHelper
  def assert_autocorrects(before, after)
    suppress_warnings do
      IO.write(TEMP_FILE_PATH, before)

      begin
        load TEMP_FILE_PATH, true
      rescue StandardError => e
        require "i_did_mean"
        IDidMean.call(e)
      end

      result = IO.read(TEMP_FILE_PATH)
      assert_equal after, result
    ensure
      File.delete(TEMP_FILE_PATH) if File.exist?(TEMP_FILE_PATH)
    end
  end
end

MiniTest::Test.include(DidYouMean::TestHelper)
MiniTest::Test.extend(IDidMean::FileTestHelpers)

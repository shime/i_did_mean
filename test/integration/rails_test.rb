# frozen_string_literal: true

require "test_helper"

skip_on_load_errors do
  require "rails"
  require "rails/test_help"

  class IDidMean::RailsTest < Minitest::Test
    include Rack::Test::Methods

    FIXTURE_PATH = File.expand_path("../../test/fixtures/rails_app.rb", __dir__)

    replace_text_in_file(FIXTURE_PATH, "render plain: autofix_me", "render plain: atofix_me")

    require File.expand_path(FIXTURE_PATH, __dir__)

    def setup
      self.class.replace_text_in_file(FIXTURE_PATH, "render plain: autofix_me", "render plain: atofix_me")
    end

    def app
      Rails.application
    end

    def test_should_correct_method_name
      get "/"
      sleep 5
      text = File.read(FIXTURE_PATH)

      refute_match(/atofix_me/, text)
    end
  end
end

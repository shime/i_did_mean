# frozen_string_literal: true

require "test_helper"
require "i_did_mean"

class HandlingUnknownErrorsTest < Minitest::Test
  class ObscureError
    def corrections
      ["obscure"]
    end

    def backtrace
      ["backtrace"]
    end

    def message
      "Very obscure error"
    end
  end

  def test_doesnt_explode_on_unknown_errors
    IDidMean.call(ObscureError.new)
  end
end

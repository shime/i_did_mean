# frozen_string_literal: true

class KeyNameAutocorrectTest < Minitest::Test
  def test_autocorrects_key_name_with_fetch
    assert_autocorrects %(
      hash = { "foo" => 1, bar: 2 }
      hash.fetch(:bax)
    ), %(
      hash = { "foo" => 1, bar: 2 }
      hash.fetch(:bar)
    )
  end

  def test_autocorrects_key_name_with_fetch_values
    assert_autocorrects %(
      hash = { "foo" => 1, bar: 2 }
      hash.fetch_values("foo", :bar, :bax)
    ), %(
      hash = { "foo" => 1, bar: 2 }
      hash.fetch_values("foo", :bar, :bar)
    )
  end

  def test_autocorrects_sprintf_key_name
    assert_autocorrects %(
      sprintf("%<fooo>d", {foo: 1})
    ), %(
      sprintf("%<foo>d", {foo: 1})
    )
  end

  def test_autocorrects_env_key_name
    ENV["FOO"] = "1"
    ENV["BAR"] = "2"
    assert_autocorrects %(
      ENV.fetch("BAX")
    ), %(
      ENV.fetch("BAR")
    )
  ensure
    ENV.delete("FOO")
    ENV.delete("BAR")
  end
end

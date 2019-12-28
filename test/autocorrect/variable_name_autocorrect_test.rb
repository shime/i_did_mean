# frozen_string_literal: true

require "test_helper"

class VariableNameCheckTest < Minitest::Test
  def test_autocorrects_method_typo
    assert_autocorrects %(
      def first_name; end
      flrst_name
    ), %(
      def first_name; end
      first_name
    )
  end

  def test_autocorrects_variable_typo
    assert_autocorrects %(
      first_name = nil
      flrst_name
    ), %(
      first_name = nil
      first_name
    )
  end

  def test_autocorrects_ruby_predefined_objects
    assert_autocorrects %(fals), %(false)
    assert_autocorrects %(treu), %(true)
    assert_autocorrects %(nul), %(nil)
  end

  def test_autocorrects_yield
    assert_autocorrects %(yeild), %(yield)
  end

  def test_autocorrects_instance_variable_name
    assert_autocorrects %(
      class User
        def initialize
          @email_address = "john@example.com"
        end

        def to_s
          email_address
        end
      end

      @user = User.new
      @user.to_s
    ), %(
      class User
        def initialize
          @email_address = "john@example.com"
        end

        def to_s
          @email_address
        end
      end

      @user = User.new
      @user.to_s
    )
  end

  def test_autocorrects_private_method
    assert_autocorrects %(
      class User
        def to_s
          naem
        end

        private

        def name
          :foo
        end
      end

      @user = User.new
      @user.to_s
    ), %(
      class User
        def to_s
          name
        end

        private

        def name
          :foo
        end
      end

      @user = User.new
      @user.to_s
    )
  end

  def test_does_not_engage_when_there_are_no_suggestions
    assert_autocorrects %(foo), %(foo)
  end
end

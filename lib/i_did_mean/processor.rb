# frozen_string_literal: true

module IDidMean
  class Processor
    def initialize(error)
      @error = error

      return if backtrace.empty?

      @file, @number = backtrace.first.split(":").first(2)

      save_original_formatter
    end

    def call
      return unless File.exist?(file)

      if should_process?
        replace_line(number)
        replace_formatter
      else
        restore_original_formatter
      end
    end

    def should_process?
      # Only process this error if:
      #   * error is present (**surprise, surprise**)
      #   * error was corrected (did_you_mean has done its magic)
      error&.respond_to?(:corrections) &&
        # * there is only one correction, so we can be certain to replace
        error.corrections.length == 1 &&
        # * this is not some internal backtrace (considering Rails here)
        backtrace.first
    end

    private

    attr_reader :error
    attr_reader :file
    attr_reader :number
    attr_reader :original_formatter

    # Extracts method name from error message.
    # Example:
    #
    #   For this error message:
    #
    #     NameError: undefined local variable or method `foo' for #<Object:0x00007fab0c28a0f0>
    #
    #   It should return "foo".
    #
    def original_method_name
      case error
      when NameError
        error.name
      when KeyError
        error.key
      end
    end

    def corrected_method_name
      error.corrections
           .first
           .to_s
           .gsub(/\A:/, "")
           .gsub(/"/, "")
    end

    def file_path
      @file_path ||= File.expand_path(file)
    end

    def lines
      @lines ||= IO.readlines(file_path)
    end

    # Used for cleaning backtrace.
    # We're only interested in application backtrace.
    # This is Rails related.
    def backtrace
      backtrace = error.backtrace
      backtrace = ::Rails.backtrace_cleaner.clean(backtrace) if defined?(::Rails)
      backtrace
    end

    def replace_line(number)
      lines[number.to_i - 1][original_method_name.to_s] = corrected_method_name
      IO.write(file_path, lines.join)
    end

    def replace_formatter
      DidYouMean.formatter = Formatter.new
    end

    def restore_original_formatter
      DidYouMean.formatter = original_formatter
    end

    def save_original_formatter
      self.original_formatter = DidYouMean.formatter
    end

    def original_formatter=(formatter)
      @original_formatter ||= formatter
    end
  end
end

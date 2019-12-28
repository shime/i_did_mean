# frozen_string_literal: true

module IDidMean
  class Formatter
    def message_for(corrections)
      "\nYou probably meant '#{corrections.first}', autofixing that."
    end
  end
end

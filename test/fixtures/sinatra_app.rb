# frozen_string_literal: true

require "sinatra"

def autofix_me
  "foo"
end

get "/" do
  "response: " + atofix_me
end

# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "i_did_mean/version"

Gem::Specification.new do |spec|
  spec.name          = "i_did_mean"
  spec.version       = IDidMean::VERSION
  spec.authors       = ["Hrvoje Simic"]
  spec.email         = ["shime@twobucks.co"]
  spec.summary       = %(Did you mean? Yes I did! Autofix your typos!)
  spec.description   = %(Autofix your typos, by leveraging DidYouMean suggestions.)
  spec.homepage      = "https://github.com/shime/i_did_mean"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "appraisal"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-focus"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop"
end

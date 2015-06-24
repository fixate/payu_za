# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payu_za/version'

Gem::Specification.new do |spec|
  spec.name          = "payu_za"
  spec.version       = PayuZa::VERSION
  spec.authors       = ["Stan Bondi"]
  spec.email         = ["stan@fixate.it"]
  spec.summary       = %q{PayU ZA Enterprise SOAP API integration}
  spec.description   = <<-README
  PayU ZA Enterprise SOAP Api integration

  Provides an easy-to-use ruby to the tricky SOAP api.
  README
  spec.homepage      = "https://github.com/fixate/payu_za"
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*', '[A-Z]*'] - ['Gemfile.lock']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "savon", "~> 2.11"

  # We use active support for:
  # - String.camelize
  # - String.constantize
  # - String.underscore
  spec.add_dependency "activesupport", "~> 3", "~> 4"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "webmock", "~> 1.21"
end

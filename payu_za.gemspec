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
  spec.description   = %q{PayU ZA Enterprise SOAP API integration}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*', '[A-Z]*'] - ['Gemfile.lock']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "savon", "~> 2.11.1"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3.0"
  spec.add_development_dependency "webmock", "~> 1.21.0"
end

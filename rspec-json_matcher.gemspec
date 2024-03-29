require 'English'
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/json_matcher/version'

Gem::Specification.new do |spec|
  spec.name          = 'rspec-json_matcher'
  spec.version       = RSpec::JsonMatcher::VERSION
  spec.authors       = ['Ryo Nakamura']
  spec.email         = ['r7kamura@gmail.com']
  spec.description   = 'This library provides RSpec matcher for testing JSON string.'
  spec.summary       = 'RSpec matcher for testing JSON string'
  spec.homepage      = 'https://github.com/r7kamura/rspec-json_matcher'
  spec.license       = 'MIT'

  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'json'
  spec.add_dependency 'amazing_print'
end

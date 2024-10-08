# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'limit_detectors/version'

Gem::Specification.new do |spec|
  spec.name          = 'limit_detectors'
  spec.version       = LimitDetectors::VERSION
  spec.authors       = ['Stephan Kämper']
  spec.email         = ['the.tester@seasidetesting.com']
  spec.summary       = 'Detect certain conditions of elements of an Enumerable object'
  spec.description   = 'Some methods to detect whether an Enumerable object contains a constrained number of elements that match a given condition.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']


  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end

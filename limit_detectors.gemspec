# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'limit_detectors/version'

Gem::Specification.new do |spec|
  spec.name                  = 'limit_detectors'
  spec.version               = LimitDetectors::VERSION
  spec.authors               = ['Stephan Kämper']
  spec.email                 = ['the.tester@seasidetesting.com']
  spec.summary               = 'Detect conditions of elements of an Enumerable object'
  spec.description           = 'Detect if an Enumerable object contains at least/most x elements matching a condition.'
  spec.homepage              = 'https://github.com/s2k/limit_detectors'
  spec.license               = 'MIT'
  spec.executables           = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths         = ['lib']
  spec.required_ruby_version = '>= 3.1.0'
  spec.files                 = `git ls-files -z`.split("\x0")

  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end

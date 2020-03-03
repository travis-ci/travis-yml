# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'travis/yml/version'

Gem::Specification.new do |s|
  s.name         = 'travis-yml'
  s.version      = Travis::Yml::VERSION
  s.author       = 'Travis CI GmbH'
  s.email        = 'contact@travis-ci.com'
  s.homepage     = 'https://github.com/travis-ci/travis-yml'
  s.licenses     = ['MIT']
  s.summary      = 'Travis CI build config processing'
  s.description  = 'Travis CI build config processing.'

  s.files        = Dir.glob('{lib/**/*,[A-Z]*}')
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'

  s.add_dependency 'amatch', '~> 0.4.0'
  s.add_dependency 'oj', '~> 3.7.10'
  s.add_dependency 'ruby-obj', '~> 1.0.0'
  s.add_dependency 'memoyze', '~> 0.0.1'
  s.add_dependency 'regstry', '~> 1.0.2'
  s.add_dependency 'sh_vars', '~> 1.0.0'
  s.add_dependency 'travis-conditions', '~> 1.0.5'
  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'
end

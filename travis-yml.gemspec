# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'travis/yaml/version'

Gem::Specification.new do |s|
  s.name         = 'travis-yml'
  s.version      = Travis::Yaml::VERSION
  s.author       = 'Travis CI GmbH'
  s.email        = 'contact@travis-ci.com'
  s.homepage     = 'https://github.com/travis-ci/travis-yml'
  s.licenses     = ['MIT']
  s.summary      = 'Travis CI build config processing'
  s.description  = 'Travis CI build config processing.'

  s.files        = Dir.glob('{lib/**/*,[A-Z]*}')
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'

  s.add_dependency 'activesupport'
  s.add_dependency 'amatch'
  s.add_dependency 'oj'
  s.add_dependency 'puma'
  s.add_dependency 'rack'
  s.add_dependency 'rack-cors'
  s.add_dependency 'rack-ssl-enforcer'
  s.add_dependency 'sentry-raven'
  s.add_dependency 'travis-conditions'
  s.add_dependency 'travis-config'

  s.add_development_dependency 'activerecord'
  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'foreman'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'rspec'
end

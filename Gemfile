source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

gem 'redcarpet'
gem 'thwait'
gem 'travis-conditions', git: 'https://github.com/travis-ci/travis-conditions'

group :web do
  gem 'puma', '~> 6.3.0'
  gem 'sinatra', '~> 2'
  gem 'sinatra-contrib'
  gem 'rack-cors'
  gem 'rack-ssl-enforcer', '~> 0.2.9'
  gem 'sentry-raven', '~> 3.1.2'
  gem 'travis-config', git: 'https://github.com/travis-ci/travis-config'
  gem 'travis-metrics', git: 'https://github.com/travis-ci/travis-metrics', ref: 'sf-unfork'
end

group :test do
  gem 'dpl', git: 'https://github.com/travis-ci/dpl.git'
  gem 'json-schema'
  gem 'pry'
  gem 'rack-test'
  gem 'rake'
  gem 'rexml'
  gem 'rspec'
  gem 'webmock'
end

gemspec

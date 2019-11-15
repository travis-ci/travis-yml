source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

gem 'redcarpet'

group :web do
  gem 'puma', '~> 3.12.0'
  gem 'rack', '~> 2.0.6'
  gem 'rack-cors', '~> 1.0.6'
  gem 'rack-ssl-enforcer', '~> 0.2.9'
  gem 'sentry-raven', '~> 2.9.0'
  gem 'travis-config', '~> 1.1.3'
end

group :development do
  gem 'foreman'
  gem 'neatjson'
  gem 'pry'
end

group :test do
  gem 'dpl', git: 'https://github.com/travis-ci/dpl.git'
  gem 'awesome_print'
  gem 'json-schema'
  gem 'rack-test'
  gem 'rake'
  gem 'rspec'
end

gemspec

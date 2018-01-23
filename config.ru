require 'rack/cors'
require 'rack/ssl-enforcer'
require 'travis/yaml/web'
require 'travis/yaml/web/basic_auth'
require 'travis/yaml/web/env'

if Travis::Yaml::Web::Env.staging?
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: :post
    end
  end
end

use Rack::SslEnforcer if Travis::Yaml::Web::Env.production?
use Travis::Yaml::Web::BasicAuth
run Travis::Yaml::Web

if ENV['SENTRY_DSN']
  require 'raven'
  Raven.configure do |config|
    config.dsn = ENV['SENTRY_DSN']
  end
end

use Raven::Rack

require 'raven'
require 'rack/cors'
require 'rack/ssl-enforcer'
require 'travis/yml/web'

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

if ENV['SENTRY_DSN']
  Raven.configure do |config|
    config.dsn = ENV['SENTRY_DSN']
  end
  use Raven::Rack
end

run Travis::Yaml::Web


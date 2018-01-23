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

require 'raven'
Raven.configure do |config|
  return unless ENV['SENTRY_DSN']
  config.dsn = ENV['SENTRY_DSN']
end

use Raven::Rack

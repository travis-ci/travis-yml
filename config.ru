require 'raven'
require 'rack/cors'
require 'rack/ssl-enforcer'
require 'travis/yml/web'

env = Travis::Yml::Web::Env
config ||= Travis::Yml::Web::Config.load

if env.production?
  use Rack::SslEnforcer unless config.is_enterprise?
  use Travis::Yml::Web::BasicAuth

elsif env.staging?
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: :post
    end
  end
end

if dsn = ENV['SENTRY_DSN']
  Raven.configure do |config|
    config.processors -= [Raven::Processor::PostData] # send POST data
    config.dsn = dsn
  end
  use Raven::Rack
end

run Travis::Yml::Web


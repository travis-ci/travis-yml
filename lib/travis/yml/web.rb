# #frozen_string_literal: true

require 'logger'
require 'rack/cors'
require 'rack/ssl-enforcer'
require 'sinatra'
require 'sinatra/json'
require 'travis/yml'
require 'travis/yml/web/auth'
require 'travis/yml/web/config'
require 'travis/yml/web/docs'
require 'travis/yml/web/expand'
require 'travis/yml/web/metrics'
require 'travis/yml/web/parse'
require 'travis/yml/web/sentry'
require 'travis/yml/web/static'

module Travis
  module Yml
    module Web
      class << self
        attr_reader :metrics

        def setup
          @metrics ||= Travis::Metrics.setup(config.metrics.to_h, logger)
        end

        def config
          @config ||= Config.load
        end

        def logger
          Logger.new($stdout)
        end
      end

      class App < Sinatra::Base
        STARTED_AT = Time.now

        def self.config
          Web.config
        end

        use Rack::Cors, debug: true, logger: Logger.new($stdout) do
          allow do
            origins '*'
            resource '*', headers: :any, methods: :any
          end
        end

        configure :production, :staging do
          use Rack::SslEnforcer unless config.enterprise?
          use Sentry if ENV['SENTRY_DSN']
          use Auth, config.auth_keys
          use Metrics
        end

        use Expand
        use Parse
        use Static, 'public'
        use Static, 'public/docs'
        # use Docs

        get '/uptime' do
          status 200
          uptime.to_s
        end

        private

          def uptime
            sec = Time.now - STARTED_AT
            sec.round
          end
      end
    end
  end
end

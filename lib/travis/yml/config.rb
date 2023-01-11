# frozen_string_literal: true
require 'travis/config'

module Travis
  module Yml
    class Config < Travis::Config
      class << self
        def auth_keys
          ENV['TRAVIS_AUTH_KEYS'].split(',') || ['abc123']
        end

        def auth_internal
          ENV['TRAVIS_AUTH_INTERNAL'] || 'token'
        end

        def travis_token
          ENV['TRAVIS_TOKEN'] || 'token'
        end

        def vcs_token
          ENV['TRAVIS_VCS_TOKEN'] || 'token'
        end
      end

      define enterprise: false,
             auth_keys:  auth_keys,
             auth:       { internal: auth_internal },
             oauth2:     {},
             github:     { url: 'https://api.github.com', ssl: {} },
             travis:     { url: 'https://api.travis-ci.com', app: 'yml', token: travis_token, ssl: {} },
             metrics:    { reporter: 'librato' },
             imports:    { max: 25 },
             ssl:        {},
             vcs:        { url: 'https://vcs.travis-ci.com', token: vcs_token },
             log_level:  ENV.fetch("LOG_LEVEL", Logger::WARN)

      def metrics
        # TODO fix travis-metrics ...
        super.to_h.merge(librato: librato.to_h.merge(source: librato_source), graphite: graphite)
      end
    end
  end
end

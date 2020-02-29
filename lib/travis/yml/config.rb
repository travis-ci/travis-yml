# frozen_string_literal: true
require 'travis/config'

module Travis
  module Yml
    class Config < Travis::Config
      define enterprise: false,
             auth_keys:  ['abc123'],
             auth:       { internal: 'token' },
             oauth2:     {},
             github:     { url: 'https://api.github.com', ssl: {} },
             travis:     { url: 'https://api.travis-ci.com', app: 'yml', token: 'token', ssl: {} },
             metrics:    { reporter: 'librato' },
             imports:    { max: 25 },
             ssl:        {}

      def metrics
        # TODO fix travis-metrics ...
        super.to_h.merge(librato: librato.to_h.merge(source: librato_source), graphite: graphite)
      end
    end
  end
end

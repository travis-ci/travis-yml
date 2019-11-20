# frozen_string_literal: true
require 'oj'
require 'travis/yml/web/route'
require 'travis/yml/web/v1/decorators/error'
require 'travis/yml/web/v1/decorators/matrix'

module Travis::Yml::Web
  module V1
    class Expand
      include Route

      def post(env)
        req = Rack::Request.new(env)
        body = req.body.read
        config = Oj.load(body, symbol_keys: true, mode: :strict, empty_string: false)
        config, data = config.values_at(:config, :data) if config[:config]
        rows = Travis::Yml.matrix(config, data || {}).rows

        [200, headers, body(Decorators::Matrix, rows)]
      rescue Oj::Error, EncodingError => e
        [400, headers, body(Decorators::Error, e)]
      end
    end
  end
end

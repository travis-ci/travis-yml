# frozen_string_literal: true
require 'oj'
require 'travis/yml/web/route'
require 'travis/yml/web/v1/decorators/config'
require 'travis/yml/web/v1/decorators/error'

module Travis::Yml
  module Web
    module V1
      class Parse
        include Route

        MIME_TYPE = 'application/vnd.travis-ci.configs+json'

        def post(env)
          [200, headers, body(Decorators::Config, parse(env))]
        rescue Travis::Yml::InputError, Psych::SyntaxError => error
          [400, headers, body(Decorators::Error, error)]
        rescue Travis::Yml::InternalError, KeyError => error
          Raven.capture_exception(error, message: error.message, extra: { env: env })
          [500, headers, body(Decorators::Error, error)]
        end

        def parse(env)
          req = Rack::Request.new(env)
          query = Rack::Utils.parse_query(req.query_string)
          body  = req.body.read
          parts = configs?(env) ? configs(body) : [config(body)]
          Travis::Yml.load(parts, opts(query))
        end

        def opts(query)
          {
            alert:    true?(query['alert']),
            defaults: true?(query['defaults'])
          }
        end

        def true?(obj)
          obj == 'true'
        end

        def configs?(env)
          env['CONTENT_TYPE'] == MIME_TYPE
        end

        def config(body)
          Parts::Part.new(body)
        end

        def configs(json)
          Oj.load(json).map do |part|
            Parts::Part.new(*part.values_at(*%w(config source merge_mode)))
          end
        end
      end
    end
  end
end

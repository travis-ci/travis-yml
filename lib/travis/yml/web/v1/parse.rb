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
        rescue Travis::Yml::InputError, Psych::SyntaxError, Oj::ParseError => e
          [400, headers, body(Decorators::Error, e)]
        rescue Travis::Yml::InternalError, KeyError => e
          capture(e)
          [500, headers, body(Decorators::Error, e)]
        rescue => e
          capture(e)
          raise
        end

        def parse(env)
          req = Rack::Request.new(env)
          query = Rack::Utils.parse_query(req.query_string)
          @body = req.body.read
          parts = configs?(env) ? configs(@body) : [config(@body)]
          Travis::Yml.load(parts, opts(query))
        end

        def opts(query)
          keys = OPTS.keys.map(&:to_s) & query.keys
          symbolize(keys.map { |key| [key, query[key.to_s] == 'true'] }.to_h)
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

        def capture(error)
          p [:debug_body, @body.inspect]
          Raven.capture_exception(error, message: error.message, extra: { env: env, body: @body }) if defined?(Raven)
        end

        def symbolize(hash)
          hash.map { |key, value| [key.to_sym, value] }.to_h
        end

        def compact(hash)
          hash.reject { |_, value| value.nil? }
        end
      end
    end
  end
end

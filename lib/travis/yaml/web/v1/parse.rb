# frozen_string_literal: true
require 'oj'
require 'travis/yaml/web/route'
require 'travis/yaml/web/v1/decorators/config'
require 'travis/yaml/web/v1/decorators/error'

module Travis::Yaml
  module Web
    module V1
      class Parse
        include Route

        def post(env)
          [200, headers, body(Decorators::Config, parse(env))]
        rescue Travis::Yaml::InputError, Psych::SyntaxError => error
          [400, headers, body(Decorators::Error, error)]
        rescue Travis::Yaml::InternalError, KeyError => error
          [500, headers, body(Decorators::Error, error)]
        end

        def parse(env)
          req = Rack::Request.new(env)
          query = Rack::Utils.parse_query(req.query_string)
          body = multipart?(env) ? multiparts(env, query) : req.body.read
          alert = query['alert'] == 'true'
          Travis::Yaml.load(body, alert: alert)
        end

        def multipart?(env)
          env['CONTENT_TYPE'].start_with?('multipart')
        end

        PREFIX = 'config://'

        def multiparts(env, query)
          modes = [:merge] + query.fetch('merge_mode', '').split(',')
          parts = env.select { |key, _| key.start_with?(PREFIX) }
          parts = parts.map { |key, file| [key.sub(PREFIX, ''), file.read] }
          parts.map.with_index { |(src, str), i| Part.new(str, src, modes[i]) }
        end
      end
    end
  end
end

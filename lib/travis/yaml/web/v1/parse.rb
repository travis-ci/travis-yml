require 'oj'
require 'travis/yaml/web/route'
require 'travis/yaml/web/v1/decorators/config'
require 'travis/yaml/web/v1/decorators/error'

module Travis::Yaml::Web
  module V1
    class Parse
      include Route

      def post(env)
        req = Rack::Request.new(env)
        body = req.body.read
        query = Rack::Utils.parse_query(req.query_string)
        alert = query['alert'.freeze] == 'true'.freeze
        config = Travis::Yaml.load(body, alert: alert)

        [200, headers, body(Decorators::Config, config)]
      rescue Travis::Yaml::InputError, Psych::SyntaxError => error
        [400, headers, body(Decorators::Error, error)]
      rescue Travis::Yaml::InternalError => error
        [500, headers, body(Decorators::Error, error)]
      end
    end
  end
end

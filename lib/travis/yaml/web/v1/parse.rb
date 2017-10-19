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
        config = Travis::Yaml.load(body)

        [200, headers, body(Decorators::Config, config)]
      rescue Travis::Yaml::InputError => error
        [400, headers, body(Decorators::Error, error)]
      rescue Travis::Yaml::InternalError => error
        [500, headers, body(Decorators::Error, error)]
      end
    end
  end
end

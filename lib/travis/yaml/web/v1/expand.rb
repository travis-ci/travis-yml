require 'oj'
require 'travis/yaml/web/route'
require 'travis/yaml/web/v1/decorators/error'
require 'travis/yaml/web/v1/decorators/matrix'

module Travis::Yaml::Web
  module V1
    class Expand
      include Route

      def post(env)
        req = Rack::Request.new(env)
        body = req.body.read
        config = Oj.load(body, mode: :strict, empty_string: false)

        [200, headers, body(Decorators::Matrix, config)]
      rescue Oj::Error, EncodingError => error
        [400, headers, body(Decorators::Error, error)]
      end
    end
  end
end

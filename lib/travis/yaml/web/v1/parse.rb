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

        [200, { 'Content-Type' => 'application/json' }, [Oj.dump(Decorators::Config.new(config).decorate)]]
      rescue Travis::Yaml::InputError => e
        [400, { 'Content-Type' => 'application/json' } , [Oj.dump(Decorators::Error.new(e).decorate)]]
      rescue Travis::Yaml::InternalError => e
        [500, { 'Content-Type' => 'application/json' } , [Oj.dump(Decorators::Error.new(e).decorate)]]
      end
    end
  end
end

require 'oj'
require 'travis/yaml'
require 'travis/yaml/web/v1/routes/route'

module Travis::Yaml::Web::V1::Routes
  class Parse
    include Route

    def post(env)
      req = Rack::Request.new(env)
      body = req.body.read
      config = Travis::Yaml.load(body)

      response = {
        'version' => 'v1',
        'messages' => config.msgs.map { |m| Travis::Yaml.msg(m) },
        'config' => config.serialize
      }

      [200, { 'Content-Type' => 'application/json' }, [Oj.dump(response)]]
    end
  end
end

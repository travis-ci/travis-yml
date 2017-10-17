require 'travis/yaml'
require 'travis/yaml/web/v1/routes/route'

module Travis::Yaml::Web::V1::Routes
  class Parse
    include Route

    def post(env)
      req = Rack::Request.new(env)
      body = req.body.read
      yaml = Travis::Yaml.load(body)
      [200, {}, [yaml.serialize.to_s]]
    end
  end
end

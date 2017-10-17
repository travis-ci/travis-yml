require 'travis/yaml/web/v1/routes/route'

module Travis::Yaml::Web::V1::Routes
  class Home
    include Route

    def get(env)
      [200, {}, ['Hello, world!'.freeze]]
    end
  end
end

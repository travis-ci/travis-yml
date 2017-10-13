require 'travis/yaml/web/routes/route'

module Travis::Yaml::Web::Routes
  class Home
    include Route

    def get(env)
      [200, {}, ['Hello, world!'.freeze]]
    end
  end
end

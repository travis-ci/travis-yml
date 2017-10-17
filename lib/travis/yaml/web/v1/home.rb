require 'travis/yaml/web/route'

module Travis::Yaml::Web
  module V1
    class Home
      include Route

      def get(env)
        [200, {}, ['Hello, world!'.freeze]]
      end
    end
  end
end

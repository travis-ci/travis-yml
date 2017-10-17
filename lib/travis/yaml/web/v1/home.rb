require 'oj'
require 'travis/yaml/web/route'

module Travis::Yaml::Web
  module V1
    class Home
      include Route

      def get(env)
        [200, { 'Content-Type' => 'application/json' }, [Oj.dump('version' => 'v1')]]
      end
    end
  end
end

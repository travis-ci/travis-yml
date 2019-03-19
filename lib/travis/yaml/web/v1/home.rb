# frozen_string_literal: true
require 'oj'
require 'travis/yaml/web/route'

module Travis::Yaml::Web
  module V1
    class Home
      include Route

      def get(env)
        [200, headers, [Oj.dump('version'.freeze => 'v1'.freeze)]]
      end
    end
  end
end

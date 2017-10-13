require 'travis/yaml/web/routes/home'
require 'travis/yaml/web/routes/parse'

module Travis
  module Yaml
    class Web
      def call(env)
        router.call(env)
      end

      def router
        @router ||= Rack::URLMap.new(
          '/' => Routes::Home.new,
          '/parse' => Routes::Parse.new
        )
      end
    end
  end
end

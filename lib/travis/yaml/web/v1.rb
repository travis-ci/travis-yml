require 'travis/yaml/web/router'
require 'travis/yaml/web/v1/expand'
require 'travis/yaml/web/v1/home'
require 'travis/yaml/web/v1/parse'

module Travis::Yaml::Web
  module V1
    extend self

    def call(env)
      router.call(env)
    end

    def router
      @router ||= Router.new(
        '/' => V1::Home.new,
        '/parse' => V1::Parse.new,
        '/expand' => V1::Expand.new
      )
    end
  end
end

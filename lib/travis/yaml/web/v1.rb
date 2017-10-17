require 'travis/yaml/web/router'
require 'travis/yaml/web/v1/routes/home'
require 'travis/yaml/web/v1/routes/parse'

module Travis::Yaml::Web
  module V1
    extend self

    def call(env)
      router.call(env)
    end

    def router
      @router ||= Router.new(
        '/' => V1::Routes::Home.new,
        '/parse' => V1::Routes::Parse.new
      )
    end
  end
end

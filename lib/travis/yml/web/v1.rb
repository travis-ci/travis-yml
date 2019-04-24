# frozen_string_literal: true
require 'travis/yml/web/router'
require 'travis/yml/web/v1/css'
require 'travis/yml/web/v1/docs'
require 'travis/yml/web/v1/expand'
require 'travis/yml/web/v1/home'
require 'travis/yml/web/v1/parse'

module Travis::Yml::Web
  module V1
    extend self

    def call(env)
      router.call(env)
    end

    def router
      @router ||= Router.new(
        '/'       => V1::Home.new,
        '/css/*'  => V1::Css.new,
        '/docs/*' => V1::Docs.new,
        '/parse'  => V1::Parse.new,
        '/expand' => V1::Expand.new
      )
    end
  end
end

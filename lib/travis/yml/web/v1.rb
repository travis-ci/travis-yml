# frozen_string_literal: true
require 'travis/yml/web/router'
require 'travis/yml/web/v1/css'
require 'travis/yml/web/v1/docs'
require 'travis/yml/web/v1/expand'
require 'travis/yml/web/v1/parse'
require 'travis/yml/web/v1/static'

module Travis::Yml::Web
  module V1
    extend self

    def call(env)
      router.call(env)
    end

    def router
      @router ||= Router.new(
        '/favicon.ico' => V1::Static,
        '/css/*'  => V1::Static,
        '/parse'  => V1::Parse,
        '/expand' => V1::Expand,
        '/*'      => V1::Docs,
      )
    end
  end
end

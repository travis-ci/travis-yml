#frozen_string_literal: true
require 'rack'
require 'travis/yml/web/basic_auth'
require 'travis/yml/web/env'
require 'travis/yml/web/v1'

module Travis
  module Yml
    module Web
      extend self

      def call(env)
        req = Rack::Request.new(env)
        path_info = req.path_info.split(?/)[1]
        path_info = "" if !path_info
        prefix = ?/ + path_info
        versions.each do |p, app|
          if p == prefix
            req.path_info = req.path_info[p.size..-1]
            req.script_name = req.script_name + p
            return app.call(env)
          end
        end
        [404, {}, []]
      end

      def versions
        { '/v1' => V1 }
      end
    end
  end
end

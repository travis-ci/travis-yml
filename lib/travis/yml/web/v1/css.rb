# frozen_string_literal: true
require 'oj'
require 'rack/markdown'
require 'travis/yml/web/route'

module Travis::Yml::Web
  module V1
    class Css
      include Route

      def get(env)
        req = Rack::Request.new(env)
        path = req.path_info.chomp(?/)
        exists?(path) ? ok(path) : not_found
      end

      def ok(path)
        [200, headers, [read(path)]]
      end

      def not_found
        [404, headers, ['Not found']]
      end

      def exists?(path)
        File.exists?(file(path))
      end

      def read(path)
        File.read(file(path))
      end

      def file(path)
        "./public#{path.sub('..', '')}"
      end

      def headers
        { 'Content-Type' => 'text/css' }
      end
    end
  end
end

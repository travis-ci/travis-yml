# frozen_string_literal: true
require 'oj'
require 'travis/yml/web/route'

module Travis::Yml::Web
  module V1
    class Static
      include Route

      attr_reader :env

      def get(env)
        @env = env
        # path = '/index.html' if path.empty?
        exists? ? ok : not_found
      end

      def ok
        [200, headers, [read]]
      end

      def not_found
        [404, headers, ['Not found']]
      end

      def exists?
        File.exists?(file)
      end

      def read
        File.read(file)
      end

      def file
        "./public#{path.sub('..', '')}.html"
      end

      def headers
        { 'Content-Type' => 'text/html' }
      end

      def path
        @path ||= req.path_info.chomp(?/)
      end

      def req
        @reg ||= Rack::Request.new(env)
      end
    end
  end
end

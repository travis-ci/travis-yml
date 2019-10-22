# frozen_string_literal: true
require 'oj'
require 'travis/yml/web/route'

module Travis::Yml::Web
  module V1
    class Static
      include Route

      CONTENT_TYPES = {
        'css'  => 'text/css',
        'html' => 'text/html',
        'ico'  => 'image/vnd.microsoft.icon'
      }

      attr_reader :env

      def get(env)
        @env = env
        exists? ? ok : not_found
      end

      def ok
        [200, headers, [read]]
      end

      def not_found
        [404, headers, ['Not found']]
      end

      def exists?
        File.exists?(path)
      end

      def read
        File.read(path)
      end

      def ext
        File.extname(path).sub('.', '')
      end

      def headers
        { 'Content-Type' => CONTENT_TYPES[ext] }
      end

      def path
        @path ||= "./public/#{req.path_info.gsub('..', '').chomp(?/)}"
      end

      def req
        @reg ||= Rack::Request.new(env)
      end
    end
  end
end

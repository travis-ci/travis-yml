# frozen_string_literal: true
require 'travis/yml/web/route'

module Travis::Yml::Web
  module V1
    class Docs
      include Route

      attr_reader :pages, :path

      # def get(env)
      #   @env = env
      #   req = Rack::Request.new(env)
      #   path = req.path_info.chomp(?/)
      #   @prefix = 'docs' if path.sub!(%r(docs), '')
      #   path = 'nodes' if path.empty?
      #   path = path.sub(%r(^/), '')
      #   @path = [prefix, path].compact.join('/')
      #   exists? ? ok : not_found
      # end

      def get(env)
        @env = env
        req = Rack::Request.new(env)
        path = req.path_info.chomp(?/)
        path = '/' if path.empty?
        @path = path
        exists? ? ok : not_found
      end

      def ok
        [200, headers, [page]]
      end

      def not_found
        [404, headers, ['Not found']]
      end

      def exists?
        pages.key?(path)
      end

      def page
        pages[path].render(format: :html)
      end

      def pages
        Travis::Yml::Docs.pages
      end

      # def pages
      #   Travis::Yml::Docs.pages(path: prefix)
      # end
      #
      # def prefix
      #   prefix = [@env[:prefix], @prefix].compact.join('/')
      #   prefix.empty? || prefix.start_with?('/') ? prefix : "/#{prefix}"
      # end

      def headers
        { 'Content-Type' => 'text/html' }
      end

      class Erb < Struct.new(:tpl)
        def render(content, menu)
          ERB.new(tpl).result(binding)
        end
      end
    end
  end
end

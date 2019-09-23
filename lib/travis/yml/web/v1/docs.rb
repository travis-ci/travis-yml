# frozen_string_literal: true
require 'travis/yml/web/route'

module Travis::Yml::Web
  module V1
    class Docs
      include Route

      def get(env)
        req = Rack::Request.new(env)
        path = req.path_info.chomp(?/).sub(%r(/docs), '')
        path = '/nodes' if path.empty?
        path = "/v1/docs#{path}"
        exists?(path) ? ok(path) : not_found
      end

      def ok(path)
        [200, headers, [page(path)]]
      end

      def not_found
        [404, headers, ['Not found']]
      end

      def exists?(path)
        pages.key?(path)
      end

      def page(path)
        pages[path].render(format: :html)
      end

      def pages
        Travis::Yml::Docs.pages(path: '/v1/docs')
      end

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

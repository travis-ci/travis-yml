# frozen_string_literal: true
require 'erb'
require 'rack/markdown'
require 'travis/yml/web/route'

module Travis::Yml::Web
  module V1
    class Docs
      include Route

      LAYOUT = <<~erb
        <html>
          <head>
            <link rel="stylesheet" type="text/css" href="/v1/css/docs/github.css" />
            <link rel="stylesheet" type="text/css" href="/v1/css/docs/syntax.css" />

            <style>
              li {
                margin: 0;
              }
              body {
                display: flex;
              }
              #index {
                padding: 0px 90px 0px 0px;
                background-color: white;
              }
              #index ul {
                margin: 0;
                padding: 0;
              }
              #index li {
                list-style-type: none;
              }
              #content {
                width: 750px;
              }
              .corner-ribbon {
                position: absolute;
                top: 25px;
                right: -50px;
                left: auto;
                width: 200px;
                background: #2c7;
                text-align: center;
                line-height: 50px;
                letter-spacing: 1px;
                font-weight: bold;
                color: #f0f0f0;
                transform: rotate(45deg);
                -webkit-transform: rotate(45deg);
              }
            </style>
          </head>
          <body>
            <div id="index">
              <%= index %>
            </div>
            <div id="content">
              <%= content %>
            </div>
            <div class="corner-ribbon">Experimental</div>
          </body>
        </html>
      erb

      def get(env)
        req = Rack::Request.new(env)
        path = req.path_info.chomp(?/).sub(%r(/docs/), '')
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
        Erb.new(LAYOUT).render(content(path), index)
      end

      def content(path)
        markdown(pages[path].render)
      end

      def markdown(markdown)
        Rack::Markdown::Renderer.render(markdown)
      end

      def index
        markdown(Travis::Yml::Docs.index)
      end

      def pages
        Travis::Yml::Docs.pages
      end

      def headers
        { 'Content-Type' => 'text/html' }
      end

      class Erb < Struct.new(:tpl)
        def render(content, index)
          ERB.new(tpl).result(binding)
        end
      end
    end
  end
end

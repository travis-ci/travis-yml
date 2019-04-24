# frozen_string_literal: true
require 'oj'
require 'rack/markdown'
require 'travis/yml/web/route'

Rack::Markdown::CSS.class_eval do
  def external
    hrefs = %w(/v1/css/docs/github.css /v1/css/docs/syntax.css)
    links = hrefs.map { |h| "<link rel='stylesheet' type='text/css' href='#{h}' />" }
    links.join
  end
end

Rack::Markdown::HTML.class_eval do
  def body
    <<-HTML
      <style>
        li {
          margin: 0;
        }
        #outer {
          display: flex;
        }
        #index {
          flex: 200px;
          padding: 30px;
          background-color: white;
        }
        #index ul {
          margin: 0;
          padding: 0;
        }
        #index li {
          list-style-type: none;
        }
        #inner {
          border: 0;
        }
      </style>
      <div id='outer'>
        <div id='index'>
          #{index}
        </div>
        <div id='inner'>
          #{rendered}
        </div>
      </div>
    HTML
  end
end

Rack::Markdown.class_eval do
  def index
    Rack::Markdown::Renderer.render(File.read('public/docs/index.md'))
  end
end

module Travis::Yml::Web
  module V1
    class Docs
      include Route

      def get(env)
        req = Rack::Request.new(env)
        path = req.path_info.chomp(?/)
        exists?(path) ? ok(path) : not_found
      end

      def ok(path)
        Rack::Markdown.new(file(path)).call(nil)
      end

      def not_found
        [404, headers, ['Not found']]
      end

      def exists?(path)
        File.exists?(file(path))
      end

      def file(path)
        "./public#{path.sub('..', '')}.md"
      end

      def headers
        { 'Content-Type' => 'text/html' }
      end
    end
  end
end

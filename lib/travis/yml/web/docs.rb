# frozen_string_literal: true

require 'travis/yml/web/helpers'

module Travis
  module Yml
    module Web
      class Docs < Sinatra::Base
        include Helpers

        get '*' do
          exists? ? ok : not_found
        end

        def ok
          content_type 'text/html'
          page
        end

        def exists?
          pages.key?(path)
        end

        def page
          pages[path].render(format: :html)
        end

        def pages
          Yml::Docs.pages
        end

        def path
          path = request.path_info
          path == '/' ? path : path.chomp(?/)
        end
      end
    end
  end
end

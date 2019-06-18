require 'travis/yml/docs/page/base'

module Travis
  module Yml
    module Docs
      module Page
        class Index < Base
          def initialize(pages, opts)
            super(nil, opts)
            @pages = pages
          end

          def render
            super(:index)
          end

          def pages
            pages = @pages.reject { |page| hide?(page) }
            root  = pages.detect(&:root?)
            pages = pages.sort_by(&:id)
            pages
          end

          def id
            :index
          end

          def namespace
          end

          def children
            []
          end

          def title
            'Index'
          end

          def path
            path_to('index')
          end

          def internal?
            false
          end

          def deprecated?
            false
          end

          def root?
            false
          end

          def hide?(page)
            # HIDE.include?(page.id) || page.static?
            page.static?
          end
        end
      end
    end
  end
end


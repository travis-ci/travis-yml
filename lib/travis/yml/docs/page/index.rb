require 'travis/yml/docs/page/base'

module Travis
  module Yml
    module Docs
      module Page
        class Index < Base
          def initialize(parent, pages, opts)
            super(parent, nil, nil, opts)
            @pages = pages
          end

          def render(opts = {})
            super(:index, opts.merge(layout: true))
          end

          def pages
            pages = @pages.reject { |page| hide?(page) }
            root  = pages.detect(&:root?)
            pages = pages.group_by(&:id).map { |_, pages| pages.sort_by { |page| page.path.length }.first }.flatten
            pages = pages.sort_by(&:title)
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
          alias menu_title title

          def path
            path_to('index')
          end

          def publish?
            true
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


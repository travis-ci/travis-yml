require 'travis/yml/docs/page/base'

module Travis
  module Yml
    module Docs
      module Page
        class Index < Base
          # HIDE = %i(
          #   arch
          #   env_var
          #   env_vars
          #   import
          #   matrix_entries
          #   matrix_entry
          #   os
          #   service
          #   stage
          # )

          attr_reader :pages

          def initialize(pages, opts)
            super(nil, opts)
            @pages = pages
          end

          def render
            super(:index)
          end

          # def pages
          #   pages = super.values
          #   pages = pages.reject { |page| hide?(page) }
          #   root  = pages.detect(&:root?)
          #   pages = pages - [root]
          #   groups = pages.group_by(&:namespace)
          #   pages = [root, *groups[:type]]
          #   pages = pages.map(&:id).zip(pages).to_h
          #   groups = except(groups, :type)
          #   # curr = pages[current.to_sym]
          #   # curr.children = groups[current.sub(/s$/, '').to_sym] if curr
          #   pages.values
          # end

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

          def hide?(page)
            # HIDE.include?(page.id) || page.is_a?(Static) || page.deprecated?
            false
          end
        end
      end
    end
  end
end


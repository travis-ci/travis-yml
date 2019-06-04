require 'travis/yml/docs/page/render'

module Travis
  module Yml
    module Docs
      module Page
        class Index < Obj.new(:pages, :current)
          include Helper::Obj, Render

          def pages
            pages = super.values
            root  = pages.detect(&:root?)
            pages = pages - [root]
            groups = pages.group_by(&:namespace)
            pages = [root, *groups[:type]]
            pages = pages.map(&:id).zip(pages).to_h
            groups = except(groups, :type)
            curr = pages[current.to_sym]
            curr.children = groups[current.sub(/s$/, '').to_sym] if curr
            pages.values
          end

          def active?(page)
            page.path =~ /#{current.split('/').first}s?$/
          end
        end
      end
    end
  end
end


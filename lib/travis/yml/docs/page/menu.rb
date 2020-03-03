require 'travis/yml/docs/page/render'

module Travis
  module Yml
    module Docs
      module Page
        class Menu < Obj.new(:opts)
          extend Forwardable
          include Helper::Obj, Render

          def_delegators :root, :title

          def render
            super(:menu, opts)
          end

          def path
            root.path
          end

          def root
            @root ||= Docs.root(opts)
          end

          def pages
            pages = root.children[0..1]
            pages = pages + root.children[2..-1].sort_by(&:title)
            pages = pages + Docs.statics(opts)
            pages.insert(-2, Docs.index([], opts))
            pages
          end

          def hide?(page)
            HIDE.include?(page.id) || page.is_a?(Static) || page.deprecated? || page.included?
          end

          def active?(page)
            current&.include?(page.path.to_s)
          end

          def current
            opts[:current]
          end
        end
      end
    end
  end
end


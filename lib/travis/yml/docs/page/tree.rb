require 'travis/yml/docs/page/base'

module Travis
  module Yml
    module Docs
      module Page
        class Tree < Base
          def initialize(parent, node, opts)
            super(parent, nil, node, opts)
          end

          def render(*args)
            super(:tree, layout: true)
          end

          def publish?
            true
          end

          # def render_node(obj)
          #   obj.render('tree/node', opts)
          # end

          # def id
          #   :tree
          # end
          #
          # def namespace
          # end
          #
          # def title
          #   'Tree'
          # end
          #
          # def path
          #   path_to('tree')
          # end
          #
          # def internal?
          #   false
          # end
          #
          # def deprecated?
          #   false
          # end
          #
          # def root?
          #   false
          # end
        end
      end
    end
  end
end


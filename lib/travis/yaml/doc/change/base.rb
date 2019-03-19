# frozen_string_literal: true
require 'travis/yaml/support/obj'

module Travis
  module Yaml
    module Doc
      module Change
        class Base < Obj.new(:spec, :node, opts: {})
          def build(*args)
            Doc::Value.build(*args)
          end

          def changed(node)
            node = throwable(node)
            puts msg(node) if Change::DEBUG
            throw node.id, [node, true]
          end

          def throwable(node)
            until throwable?(node) || node.root?
              node.completed = false
              node = node.parent
            end
            node.completed = false
            node
          end

          def throwable?(node)
            ids.include?(node.id)
          end

          def msg(node)
            ['^^', :throw, source, node.id, node.type, node.raw.inspect].join(' ')
          end

          def source
            method = caller[2] =~ /`(.*)'/ && $1.sub('block in', '').strip
            const = self.class.name.split('::').last
            [const, method].join('#')
          end

          def ids
            opts[:ids] || []
          end
        end
      end
    end
  end
end

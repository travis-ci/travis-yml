require 'travis/yml/docs/page/base'

module Travis
  module Yml
    module Docs
      module Page
        class Seq < Base
          def pages
            [self, *build(node.schema).pages].flatten.select(&:publish?)
          end

          def display_type
            child = build(node.schema)
            # type = child.publish? ? "[#{child.title}](#{child.path})" : DISPLAY_TYPES[child.node.type]
            # DISPLAY_TYPES[:seq] % type
            if child.publish?
              [DISPLAY_TYPES[:seq] % child.title, child.path]
            else
              [DISPLAY_TYPES[:seq] % child.type.to_s.capitalize, path_to(child.type)]
            end
          end
        end
      end
    end
  end
end
